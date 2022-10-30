// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 3 ways to send eth
// transfer --> uses 2300 gas, reverts
// send --> also 2300 gas, returns bool
// call --> sends all gas, returns bool and data

// To be able to send ether contract first needs to be able to receive ether
// one way to make a contract be able to recieve ether is to make constructor payable
// another way is to have a payable fallback() or receive() function

// send is basically never used

// Below are two contracts SendEther and EthReceiver

// EthReceiver will have a receive() function that emits a Log event that tracks amount of ether received and gas cost

contract SendEther {
    constructor() payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123); /// 123 is amount of ether
    }

    function sendViaSend(address payable _to) external payable {
        // remember returns a bool so assign bool variable type to sent then check if sent was successful using require
        bool sent = _to.send(234);
        require(sent, "send failure");
    }

    
    //----------------MOST COMMONLY USED AND RECOMMENDED--------------------------
    
    function sendViaCall(address payable _to) external payable {
        // when using call it returns a bool and message data (bool success, msg.data) but we leave msg.data blank here
        // check success using require
        (bool success, ) = _to.call{ value: 345 }("");
        require(success, "call failure");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);
    // gasleft() is a global variable, if transactions sends 
    receive() external payable {
        emit Log(msg.value, gasleft()); 
    }
}