// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
/* 
TimeLock is a contract that publishes a transaction to be executed in the future. After a mimimum waiting period, the transaction can be executed.

TimeLocks are commonly used in DAOs.

2 contracts - Timelock and TimelockTest

start with 2 functions queue, and execute
*/
contract TimeLock {
    error NotOwnerError();
    error AlreadyQueuedError(bytes32 txId);
    error TxIdNotInQueueError(bytes32 txId);
    error TimestampNotInRangeError(uint blockTimestamp, uint timestamp);
    error TimeStampNotPassedError(uint blockTimestamp, uint timestamp);
    error TimestampExpiredError(uint blockTimestamp, uint expiredAt);
    error TxFailedError();

    // time is in seconds
    uint public constant MIN_DELAY = 10;
    uint public constant MAX_DELAY = 1000;
    uint public constant GRACE_PERIOD = 10000;
    
    address public owner;

    mapping(bytes32 => bool) public queued;

    event Queue(
        bytes32 txId, 
        address _target, 
        uint _value, 
        string _func, 
        bytes _data, 
        uint _timestamp
    );

    event Execute(
        bytes32 txId, 
        address _target, 
        uint _value, 
        string _func, 
        bytes _data, 
        uint _timestamp
    );

    event Cancel(bytes32 txId);

    
    constructor() {
        owner == msg.sender;
    }

    receive() external payable {}

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwnerError();
        } 
        _;
    }
    /**
     * @param _target Address of contract or account to call
     * @param _value Amount of ETH to send
     * @param _func Function signature, for example "foo(address,uint256)"
     * @param _data ABI encoded data send.
     * @param _timestamp Timestamp after which the transaction can be executed.
     */

    function getTxId(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) public pure returns (bytes32 txId) {
       return keccak256(
           abi.encode(
               _target, _value, _func, _data, _timestamp
            )
        );
    }

    function queue(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) external onlyOwner {
        // create tx id
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        // check tx id unique
        if (queued[txId]) {
            revert AlreadyQueuedError(txId);
        }
        // check timestamp
        // ---|------------|---------------|-------
        //  block    block + min     block + max
        if (
            _timestamp < block.timestamp + MIN_DELAY ||
            _timestamp > block.timestamp + MAX_DELAY 
        ) {
            revert TimestampNotInRangeError(block.timestamp, _timestamp);
        }
        // queue tx
        queued[txId] = true;
        // emit queue event
        emit Queue(txId, _target, _value, _func, _data, _timestamp);
    }

    function execute(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) external payable onlyOwner returns (bytes memory) {
        // create tx id
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        // check tx id is queued
        if (!queued[txId]) {
            revert TxIdNotInQueueError(txId);
        }
        // ----|-------------------|-------
        //  timestamp    timestamp + grace period
        if (block.timestamp < _timestamp) {
            revert TimeStampNotPassedError(block.timestamp, _timestamp);
        }

        if (_timestamp > block.timestamp + GRACE_PERIOD) {
            revert TimestampExpiredError(block.timestamp, _timestamp + GRACE_PERIOD);
        }
        // remove from queue
        queued[txId] = false;

        // prepare data
        // remember we split the data up above so we need to put it back together

        bytes memory data;
        // if _func is not empty 
        if (bytes(_func).length > 0) {
            //data = func selector + _data
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } else {
            // call fallback with data
            data = _data;           
        }   
        // call target
        (bool ok, bytes memory res) = _target.call{value:_value}(data);
            if (!ok) {
                revert TxFailedError();
            }
        
        // emit event
        emit Execute(txId, _target, _value, _func, _data, _timestamp);

        return res;
            
    }

    function cancel(bytes32 _txId) external onlyOwner {
        if (!queued[_txId]) {
            revert TxIdNotInQueueError(_txId);
        }

        queued[_txId] = false;

        emit Cancel(_txId);
    }

}

contract TestTimeLock {
    // used to call TimeLock, act as an owner and make some type of change
    address public timeLock;

    constructor(address _timeLock) {
        timeLock = _timeLock;
    }

    function test() external {
        require(msg.sender == timeLock, "only timelock contract can call");
        // more code here such as
        // - upgrade contract
        // - transfer funds
        // - switch price oracles
    }

    function getTimestamp() external view returns (uint) {
        return block.timestamp + 100;
    }
}