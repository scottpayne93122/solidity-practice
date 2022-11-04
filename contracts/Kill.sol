// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// selfdestruct
// - delete contract
// - force send Ether to any address even without a fallback()

contract Kill {

    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

// write another contract that demonstrates ability to receive ether without fallback
// Helper calls kill function from Kill contract and ether is force snet to Helper contract

contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}

// Test instructions -------------------------
// 0. deploy both contracts (sending 1 eth to Kill contract)
// 1. call kill function inside of helper passing kill contract address
// 2. call getBalance() --> should = 1 eth 
