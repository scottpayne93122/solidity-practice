// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// contract allows ownership to be transferred
// only the owner can transfer ownership
// certain functions only allow owner to be able to call
// certain functions anyone can call

// state variables
// global variables
// modifiers
// functions
// error handling
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "only owner can call");
        _;
    }

    function changeOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid owner address");
        owner = _newOwner;
    }

    function ownerCanCall() external onlyOwner {
        // some code here
    }

    function anyoneCanCall() external {
        // some code here
    }
}