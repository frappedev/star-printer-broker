<?php

class PrinttapldooDatabase {

    protected $conn;

    const PRINTER_QUEUE_PIVOT_TABLE = 'printer_printer_queue_pivot';
    const PRINTER_QUEUE_TABLE = 'printer_queues';
    const PRINTERS_TABLE = 'printers';
    const PENDING_PRINT_STATUS = 0; 
    const PRINTING_PRINT_STATUS = 1; 
    const DONE_PRINT_STATUS = 2; 

    public function __construct()
    {
        $config = require_once __DIR__.'/db-config.php';
        $this->conn = new mysqli(
            $config['host'],
            $config['username'],
            $config['password'],
            $config['database']
        );
        if ($this->conn->connect_errno) {
            throw new \Exception("MySQL connection failed!");
        }
    }

    public function query($query)
    {
        $result = $this->conn->query($query);

        if($this->conn->error) {
            throw new \Exception("Query Error " . $this->conn->error);
        }

        return $result;
    }

    public function printCurrentlyInQueueForMacAddress($macAddress)
    {
        $query = "SELECT " .
        self::PRINTERS_TABLE . ".mac_address, " .
        self::PRINTER_QUEUE_PIVOT_TABLE . ".*, " .
        self::PRINTER_QUEUE_TABLE. ".* ".
        " FROM " . self::PRINTER_QUEUE_TABLE . 
        " INNER JOIN " . self::PRINTER_QUEUE_PIVOT_TABLE .
        " ON " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printer_queue_id = " . self::PRINTER_QUEUE_TABLE . ".id ".
        " INNER JOIN " . self::PRINTERS_TABLE . 
        " ON " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printer_id = " . self::PRINTERS_TABLE . ".id ".
        " WHERE " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printing_status=" . self::PRINTING_PRINT_STATUS .
        " AND " . self::PRINTERS_TABLE . ".mac_address='" . $macAddress . "' ORDER BY " . self::PRINTER_QUEUE_TABLE . ".position ASC LIMIT 1";

        $result = $this->query($query);

        $printQueue = $result->fetch_assoc();

        if($printQueue) {
            return $printQueue['printer_id'] . "-" . $printQueue['printer_queue_id'];
        }

        return false;
    }

    public function pendingPrintInQueueForMacAddress($macAddress)
    {
        $query = "SELECT " .
        self::PRINTERS_TABLE . ".mac_address, " .
        self::PRINTER_QUEUE_PIVOT_TABLE . ".*, " .
        self::PRINTER_QUEUE_TABLE. ".* ".
        " FROM " . self::PRINTER_QUEUE_TABLE . 
        " INNER JOIN " . self::PRINTER_QUEUE_PIVOT_TABLE .
        " ON " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printer_queue_id = " . self::PRINTER_QUEUE_TABLE . ".id ".
        " INNER JOIN " . self::PRINTERS_TABLE . 
        " ON " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printer_id = " . self::PRINTERS_TABLE . ".id ".
        " WHERE " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printing_status=" . self::PENDING_PRINT_STATUS .
        " AND " . self::PRINTERS_TABLE . ".mac_address='" . $macAddress . "' ORDER BY " . self::PRINTER_QUEUE_TABLE . ".position ASC LIMIT 1";

        $result = $this->query($query);

        $printQueue = $result->fetch_assoc();

        return $printQueue;

        // if($printQueue) {
        //     $id = $printQueue['printer_id'] . "-" . $printQueue['printer_queue_id'];

        //     return $id;
        // }

        // return false;
    }

    public function markPrinterQueueDoneByMacAddress($macAddress)
    {
        $query = "UPDATE " . self::PRINTER_QUEUE_TABLE .
        " INNER JOIN " . self::PRINTER_QUEUE_PIVOT_TABLE .
        " ON " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printer_queue_id = " . self::PRINTER_QUEUE_TABLE . ".id ".
        " INNER JOIN " . self::PRINTERS_TABLE . 
        " ON " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printer_id = " . self::PRINTERS_TABLE . ".id ".
        " SET " . self::PRINTER_QUEUE_PIVOT_TABLE . ".printing_status=" . self::DONE_PRINT_STATUS . " WHERE " . self::PRINTERS_TABLE . ".mac_address = '" . $macAddress . "'";
        return $this->query($query);
    }

}