// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract StateVariables{
    // state variables are declared inside of a contract but outside a function, values are stored on blockchain
    uint public myUint = 123;

    
    // Local variables are contained within a function and only exist while function is executing
    function foo() external {
        uint notStateVariable = 456;
    }
}