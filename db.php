<?php

class PrinttapldooDatabase {

    protected $conn;

    const PRINTER_QUEUE_TABLE = 'printer_queues';
    const PRINTERS_TABLE = 'printers';
    const PENDING_PRINT_STATUS = 0; 
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

    public function pendingPrintInQueueForMacAddress($macAddress)
    {
        $query = "SELECT " .self::PRINTERS_TABLE . ".mac_address, " .self::PRINTER_QUEUE_TABLE. ".* FROM " .
        self::PRINTER_QUEUE_TABLE . " INNER JOIN " . self::PRINTERS_TABLE .
        " ON ". self::PRINTER_QUEUE_TABLE . ".team_id = " . self::PRINTERS_TABLE . ".team_id" .
        " WHERE " . self::PRINTER_QUEUE_TABLE . ".printing_status=" . self::PENDING_PRINT_STATUS .
        " AND " . self::PRINTERS_TABLE . ".mac_address='" . $macAddress . "' ORDER BY " . self::PRINTER_QUEUE_TABLE . ".position ASC LIMIT 1";

        $result = $this->query($query);

        return $result->fetch_assoc();
    }

    public function markPrinterQueueDoneByMacAddress($macAddress)
    {
        $query = "UPDATE " . self::PRINTER_QUEUE_TABLE . " INNER JOIN " . self::PRINTERS_TABLE . " ON " . self::PRINTER_QUEUE_TABLE . ".team_id = " . self::PRINTERS_TABLE . ".team_id SET " . self::PRINTER_QUEUE_TABLE . ".printing_status=" . self::DONE_PRINT_STATUS . " WHERE " . self::PRINTERS_TABLE . ".mac_address = '" . $macAddress . "'";
        return $this->query($query);
    }

}