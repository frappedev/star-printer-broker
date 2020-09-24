<?php

ini_set('display_errors', 1);

require_once __DIR__.'/vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\StreamHandler;

// create a log channel
$log = new Logger('printer-logs');
$log->pushHandler(new StreamHandler(__DIR__ . '/logs/data.log', Logger::WARNING));

$getResponse = json_encode($_GET);
$log->warning("Get Params : " . $getResponse);

$rawResponse = file_get_contents("php://input");
// get the request body, which should be in json format, and parse it
$parsed = json_decode($rawResponse, true);    

// add records to the log
$log->warning($rawResponse);

function handleCloudPRNTPoll($db)
{

    // $pollResponse = array();
    // $pollResponse['jobReady'] = false; // set jobReady to false by default, this is enough to provide the minimum cloudprnt response
    //$pollResponse['deleteMethod'] = "GET"; // set jobReady to false by default, this is enough to provide the minimum cloudprnt response

    // $deviceRegistered = setDeviceStatus($db, $parsed['printerMAC'], urldecode($parsed['statusCode']));

    // if (!$deviceRegistered) {
    //     // the request came from a printer that is not currently registered in the database.
    //     // just do nothing, allow jobReady to return false so that the cloudPrnt device doesn't take any action
    //     // Note: this can be a good time to print a 'welcome' job if required
    // } elseif (isset($parsed['clientAction'])) {
    //     // client action responses received, meaning that the cloudPRNT device has responded to a
    //     // request from the server. This server will request print/paper size and the client type/version when needed
    //     $width = 0;
    //     $ctype = "";
    //     $cver = "";

    //     $client_actions = $parsed['clientAction'];

    //     for ($i = 0; $i < count($client_actions); $i++) {
    //         if ($client_actions[$i]['request'] === "PageInfo") {
    //             $width = intval($client_actions[$i]['result']['printWidth']) * intval($client_actions[$i]['result']['horizontalResolution']);
    //         } elseif ($client_actions[$i]['request'] === "ClientType") {
    //             $ctype = strval($client_actions[$i]['result']);
    //         } elseif ($client_actions[$i]['request'] === "ClientVersion") {
    //             $cver = strval($client_actions[$i]['result']);
    //         }
    //     }

    //     setDeviceInfo($db, $parsed['printerMAC'], $width, $ctype, $cver);
    // } else {
    //     // obtain printer device info, to see if this has been stored in the database
    //     $printWidth = getDeviceOutputWidth($db, $parsed['printerMAC']);

    //     if (intval($printWidth) === 0) {
    //         // if the device width is not stored in the database, then use a client action to request it, and other device infor at the same time
    //         $pollResponse['clientAction'] = array();
    //         $pollResponse['clientAction'][0] = array("request" => "PageInfo", "options" => "");
    //         $pollResponse['clientAction'][1] = array("request" => "ClientType", "options" => "");
    //         $pollResponse['clientAction'][2] = array("request" => "ClientVersion", "options" => "");
    //     } else {
    //         // No client action is needed, so check the database to see if a ticket has been requested
    //         list($printing, $queue, $dotwidth) = getDevicePrintingRequired($db, $parsed['printerMAC']);

    //         if (isset($printing) && !empty($printing) && isset($queue)) {
    //             // a ticket has been requested, so let the device know that printing is needed
    //             $pollResponse['jobReady'] = true;

    //             // this queuing sample will always use Star Markup to define the print job, so get a list of
    //             // output formats that can be generated from a Star markup job by cputil and return it.
    //             // the device will select one format from this list, based on it's internal compatibility and capabilities
    //             $pollResponse['mediaTypes'] = getCPSupportedOutputs("text/vnd.star.markup");
    //         }
    //     }
    // }

    // header("Content-Type: application/json");
    // print_r(json_encode($pollResponse));
}

http_response_code(200);
$response = [
    'jobReady' => true,
    'mediaTypes' => ['text/plain']
];
header('Content-Type: application/json');
print json_encode($response);