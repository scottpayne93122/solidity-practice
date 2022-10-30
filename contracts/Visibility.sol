// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// visibility --> function or state variable can be accessed...
// private - only from inside contract
// internal - only from inside contract and child contracts
// public - inside and outside contract
// external - only from outside contract

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    // What state variables and functions does this function have access to?
    function example() external view {
        // since we're inside the contract we have access to x,y, and z state variables
        x + y + z;
        // we also have access to privateFunc(), internalFunc(), & publicFunc()
        privateFunc();
        internalFunc();
        publicFunc();
        // We don't however have access to externalFunc() since it can only be called outside the contract
    }
    
}

contract VisibilityChild is VisibilityBase {
    // child contracts have access to internal and public state variables from parent
    // can't call private SV or functions, can't call external functions
    function example2() external view {
        y + z; // returns 3
        internalFunc(); // returns 100
        publicFunc(); // returns 200
    }
}