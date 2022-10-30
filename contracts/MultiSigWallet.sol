// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract MultiSigWallet {
    // events
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);
    // state variables
    address[] public owners;
    mapping(address => bool) public isOwner;
    // number of approvals required before a tx can be executed
    uint public required;

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }
    // store struct in an array
    Transaction[] public transactions;
    // store approval of each transaction by each owner in mapping
    mapping(uint => mapping(address => bool)) public approved;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "only owners of contract can call this function");
        _;
    }

    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");
        
        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");

            // after checks insert owners into isOwner mapping
            isOwner[owner] = true;
            // push owner into state variable owners array
            owners.push(owner);
        }
        // assign required state variable to _required
        required = _required;
    }

    // enable contract to be able to receive ether
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        // push transactions to transactions array
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        // Emit submit event tracking transaction id
        emit Submit(transactions.length - 1);
    }

    function approve(uint _txId) 
        external 
        onlyOwner 
        txExists(_txId)
        notApproved(_txId)
        notExecuted(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function _getApprovalCount(uint _txId) private view returns(uint count) {
        for (uint i; i < owners.length; i++) {
            if(approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovalCount(_txId) >= required, "approvals < required");
        Transaction storage transaction = transactions[_txId];

        transaction.executed = true;

        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx failed");

        emit Execute(_txId);
    }

    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;

        emit Revoke(msg.sender, _txId);
    }

}