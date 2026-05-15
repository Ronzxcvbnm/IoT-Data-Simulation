// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartLogisticsTracking {

    struct LogisticsData {
        uint256 timestamp;
        string packageId;
        string location;
        string status;
        string temperature;
        string rfidTag;
    }

    uint256 public constant MAX_ENTRIES = 100;

    LogisticsData[] public records;

    address public owner;

    event DataStored(
        uint256 timestamp,
        string packageId,
        string location,
        string status,
        string temperature,
        string rfidTag
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function storeData(
        string memory _packageId,
        string memory _location,
        string memory _status,
        string memory _temperature,
        string memory _rfidTag
    ) public onlyOwner {

        require(
            records.length < MAX_ENTRIES,
            "Storage limit reached"
        );

        records.push(
            LogisticsData(
                block.timestamp,
                _packageId,
                _location,
                _status,
                _temperature,
                _rfidTag
            )
        );

        emit DataStored(
            block.timestamp,
            _packageId,
            _location,
            _status,
            _temperature,
            _rfidTag
        );
    }

    function getTotalRecords()
        public
        view
        returns (uint256)
    {
        return records.length;
    }

    function getRecord(uint256 index)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        require(index < records.length, "Index out of bounds");

        LogisticsData memory record = records[index];

        return (
            record.timestamp,
            record.packageId,
            record.location,
            record.status,
            record.temperature,
            record.rfidTag
        );
    }
}