<?php

ini_set('display_errors', 1);

require_once __DIR__.'/vendor/autoload.php';
require_once __DIR__.'/db-updated.php';

use Monolog\Logger;
use Monolog\Handler\StreamHandler;

class StarCloudPrinterHandler {
    
    private $requestMethod;
    private $payload;
    private $logger;

    const PRINTING_LOCK_FILE = __DIR__."/.printinglock";
    const BINARY_DOCKETS_FOLDER = __DIR__."/printables/binary-dockets/";
    const MARKUP_DOCKETS_FOLDER = __DIR__."/printables/markup-dockets/";

    public function __construct(PrinttapldooDatabase $db, $config=[])
    {
        $this->database = $db;
        
        if($_SERVER['REQUEST_METHOD'] == "GET" || $_SERVER['REQUEST_METHOD'] == "get") {
            $this->requestMethod = "get";
            $this->payload = $_GET;
        }
        
        if($_SERVER['REQUEST_METHOD'] == "POST" || $_SERVER['REQUEST_METHOD'] == "post") {
            $this->requestMethod = "post";
            $this->payload = json_decode(file_get_contents("php://input"), 1);
        }

        if($_SERVER['REQUEST_METHOD'] == "DELETE" || $_SERVER['REQUEST_METHOD'] == "delete") {
            $this->requestMethod = "delete";
            $this->payload = array_merge($_GET, $_POST, json_decode(file_get_contents("php://input") == "" ? "[]" : file_get_contents("php://input"), 1));
        }

    }

    public function setLogger(Logger $logger, StreamHandler $streamHandler)
    {
        $this->logger = $logger;
        $this->logger->pushHandler($streamHandler);
    }

    public function logIntoLogger($data)
    {
        if(is_array($data)) {
            $data = json_encode($data);
        }

        $this->logger->warning($data);
    }

    private function logIncomingRequests()
    {
        if(!$this->logger) {
            return false;
        }

        if($this->isDeleteRequest()) {
            $this->logIntoLogger("Delete Request Received");
        }

        $this->logIntoLogger($this->payload);

    }

    protected function isGetRequest()
    {
        return $this->requestMethod == "get";
    }

    protected function isPostRequest()
    {
        return $this->requestMethod == "post";
    }

    protected function isDeleteRequest()
    {
        return $this->requestMethod == "delete";
    }

    protected function isPrintJobRequest()
    {
        if(!$this->isGetRequest()) {
            return false;
        }

        return isset($this->payload['mac']) && isset($this->payload['type']);
    }

    protected function isPollingRequest()
    {
        if(!$this->isPostRequest()) {
            return false;
        }

        return isset($this->payload['printerMAC']) && isset($this->payload['status']);
    }

    public function delegateRequests()
    {
        $this->logIncomingRequests();

        if($this->isPollingRequest()) {
            $this->handlePollingRequest();
        }

        if($this->isPrintJobRequest()) {
            $this->handlePrintRequest();
        }

    }

    /**
     * @return string path of the printable file
     */
    private function addMarkupDocket($printId, $content)
    {
        $file = "docket-" . $printId .".stm";

        $path = self::MARKUP_DOCKETS_FOLDER . $file;

        $this->logIntoLogger($path);
        
        file_put_contents($path, $content);

        return $file;
    }

    /**
     * 
     */
    private function getMarkupDocket($file)
    {
        $path = self::MARKUP_DOCKETS_FOLDER . $file;
        return file_get_contents($path);
    }

    private function getSupportedPrintFormatsForDocket($printId)
    {
        $file = "docket-" . $printId .".stm";
        $pathToMarkUpDocket = self::MARKUP_DOCKETS_FOLDER . $file;
        $command = $this->database->getCputilPath() . " mediatypes " . $pathToMarkUpDocket;
        $command .= " 2>&1";
        $output = shell_exec($command);
        
        if($output != "") {
            return json_decode($output);
        }
        return [];
    }

    /**
     * 
     */
    private function convertMarkupToBinaryDocket($printId, $binaryFormatForConversion)
    {
        $file = "docket-" . $printId .".stm";
        $convertedFile = "docket-" . $printId .".bin";

        $pathToMarkUpDocket = self::MARKUP_DOCKETS_FOLDER . $file;
        $fullPathConvertedFile = self::BINARY_DOCKETS_FOLDER . $convertedFile;

        $command = $this->database->getCputilPath() . " decode " . $binaryFormatForConversion . " " . $pathToMarkUpDocket . " " .$fullPathConvertedFile;
        $command .= " 2>&1";
        
        shell_exec($command);

        return $convertedFile;
    }

    /**
     * 
     */
    private function getBinaryDocket($printId)
    {
        $file = "docket-" . $printId .".bin";
        $path = self::BINARY_DOCKETS_FOLDER . $file;
        return file_get_contents($path);
    }

    public function handlePrintRequest()
    {
        $printableData = "";

        try {
            $printerMacAddress = $this->getPrinterMacAddressFromPayload();
            $pendingPrintInQueue = $this->database->pendingPrintInQueueForMacAddress($printerMacAddress);
            if($pendingPrintInQueue) {
                $httpResponseCode = 200;

                // Convert the Markup Docket to 
                $this->convertMarkupToBinaryDocket($pendingPrintInQueue['id'], $this->payload['type']);

                // Get the converted Binary file
                $printableData = $this->getBinaryDocket($pendingPrintInQueue['id']);
                // $printableData = $pendingPrintInQueue['header'] . "\n\n" . $pendingPrintInQueue['content'] . "\n\n" . $pendingPrintInQueue['footer'];
                
                $this->database->markPrinterQueueDoneByMacAddress($printerMacAddress);
            
            } else {
                $httpResponseCode = 404;
                $printableData = "";
            }
        } catch(\Exception $e) {
            $httpResponseCode = 404;
            $printableData = "";
            $this->logIntoLogger("Query Database Exception: " . $e->getMessage());
            $pendingPrintInQueue = null;
        }


        http_response_code($httpResponseCode);
        header('Content-Type: ' . $this->payload['type']);
        echo $printableData;
    }

    public function getPrinterMacAddressFromPayload()
    {
        if(isset($this->payload['printerMAC'])) {
            return $this->payload['printerMAC'];
        }
        
        if(isset($this->payload['mac'])) {
            return $this->payload['mac'];
        }

        return false;
    }

    public function handlePollingRequest()
    {
        try {
            $currentPrintInQueue = $this->database->pendingPrintInQueueForMacAddress($this->getPrinterMacAddressFromPayload());
        } catch(\Exception $e) {
            $this->logIntoLogger("Query Database Exception: " . $e->getMessage());
            $currentPrintInQueue = null;
        }
        
        http_response_code(200);

        $printableFormats = [];

        // var_dump($currentPrintInQueue);
        // die();

        if($currentPrintInQueue) {
            $this->addMarkupDocket($currentPrintInQueue['id'], $currentPrintInQueue['content']);
            $printableFormats = $this->getSupportedPrintFormatsForDocket($currentPrintInQueue['id']);
        }

        $response = [
            'jobReady' => !$this->database->isPrintingLocked() && $currentPrintInQueue,
            'mediaTypes' => $printableFormats
        ];
        
        header('Content-Type: application/json');
        print json_encode($response);
    }
}

$starCloudPrinter = new StarCloudPrinterHandler(new PrinttapldooDatabase);

/* setting the loggers */
$logSteamHandler = new StreamHandler(__DIR__ . '/logs/data.log', Logger::WARNING);
$starCloudPrinter->setLogger(new Logger('printer-logs'), $logSteamHandler);

$starCloudPrinter->delegateRequests();