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

    private function isPrintingLocked()
    {
        $lockContent = file_get_contents(self::PRINTING_LOCK_FILE);
        $lockContent = preg_replace('/\s+/', '', $lockContent);
        return $lockContent != "";
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

    public function handlePrintRequest()
    {
        try {
            $printerMacAddress = $this->getPrinterMacAddressFromPayload();
            $pendingPrintInQueue = $this->database->pendingPrintInQueueForMacAddress($printerMacAddress);
            if($pendingPrintInQueue) {
                $httpResponseCode = 200;
                $printableText = $pendingPrintInQueue['header'] . "\n\n" . $pendingPrintInQueue['content'] . "\n\n" . $pendingPrintInQueue['footer'];
                $this->database->markPrinterQueueDoneByMacAddress($printerMacAddress);
            } else {
                $httpResponseCode = 404;
                $printableText = "";
            }
        } catch(\Exception $e) {
            $httpResponseCode = 404;
            $printableText = "";
            $this->logIntoLogger("Query Database Exception: " . $e->getMessage());
            $pendingPrintInQueue = null;
        }
        
        http_response_code($httpResponseCode);
        header('Content-Type: text/plain');
        echo $printableText;
        // header('Content-Type: image/png');
        // header('X-Star-Buzzerstartpattern: 1');
        // header('X-Star-Cut: partial; feed=true');
        // print file_get_contents(__DIR__."/Logo-Test.png");
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
            // $currentPrintInQueue = $this->database->printCurrentlyInQueueForMacAddress($this->getPrinterMacAddressFromPayload());
            $pendingPrintInQueue = $this->database->pendingPrintInQueueForMacAddress($this->getPrinterMacAddressFromPayload());
        } catch(\Exception $e) {
            $this->logIntoLogger("Query Database Exception: " . $e->getMessage());
            // $pendingPrintInQueue = null;
            $currentPrintInQueue = null;
        }
        
        http_response_code(200);

        // $clientAction = [];

        // if($pendingPrintInQueue) {
        //     $clientAction = [
        //         "request" => "SetID",
        //         "options" => $pendingPrintInQueue
        //     ];
        // }
        
        $response = [
            'jobReady' => !$this->isPrintingLocked() && $pendingPrintInQueue,
            'mediaTypes' => ['image/png'],
            // 'clientAction' => $clientAction
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