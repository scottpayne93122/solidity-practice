// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// If a value is never going to change in a contract declaring a state variable as a constant will 
// save gas if a function uses that state variable

contract Constants {
    address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // coding convention has name in all caps for constants
    uint public constant MY_UINT = 123;
}