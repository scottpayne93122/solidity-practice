// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract ViewAndPureFunctions {
    // View functions can read data from the blockchain >> state variables, global variables
    // pure functions are read only and cannot read data from blockchain
    uint public num;
    
    function viewFunc() external view returns (uint) {
        return num;
    }

    function pureFunc() external pure returns (uint) {
        return 1;
    }

    function addToNum(uint x) external view returns (uint) {
        return num + x;
    }

    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}