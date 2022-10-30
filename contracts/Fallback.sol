// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*
Fallback executed when
- function called by account or external contract doesn't exist in this contract 
- directly send ETH

2 types of fallback
fallback() or receive()

            Ether sent to contract
                        |
                is msg.data empty?      
                    /       \
                  yes       no
                  /           \
        receive() exists?     fallback()
                /   \
             yes     no
             /         \
        receive()       fallback()   
*/

contract Fallback {
    event Log(string funcName, address sender, uint value, bytes data);
    
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, ""); // receive() cant take msg.data so use empty string as placeholder
    }

    // when testing receive() will be triggered if Calldata is empty and fallback will trigger if transaction has calldata
}
