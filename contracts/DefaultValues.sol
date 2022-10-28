// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract DefaultValues {
    // state variables have default values
    bool public b; // default: false

    uint public x; //  default: 0 

    int public i; // default: 0 

    address public a; // default: 0x0000000000000000000000000000000000000000

    bytes32 public bt; //  default: 32 byte hexadecimal representation 0x0000000000000000000000000000000000000000000000000000000000000000
}