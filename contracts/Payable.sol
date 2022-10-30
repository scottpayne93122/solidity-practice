// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// If you want functions or addresses to receive ether you have to declare them as payable
// only thing thats a little weird is bc we assign owner to msg.sender and owner is payable, msg.sender must be cast as payable as well

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function getBalance() external view returns (uint) {
       return address(this).balance;
    }


}