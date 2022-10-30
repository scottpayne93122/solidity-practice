// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// Explains the basic syntax for writing a function in solidity
// This function adds two numbers, takes in two inputs, and returns solution
contract FunctionIntro {
    
    function add(uint a, uint b) external pure returns (uint) {
        return(a+b);
    }

    function sub(uint a, uint b) external pure returns (uint) {
        return(a - b);
    }
        
}