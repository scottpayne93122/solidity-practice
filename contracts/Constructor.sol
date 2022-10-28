// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// constructor used to initialize state variables once when contract is deployed
contract Constructor {
    address public owner;
    uint public x;

    // set owner of contract to wallet address of deployer
    // set x state variable using input _x
    constructor(uint _x) {
        x = _x;
        owner = msg.sender;
    }
}