// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// require, revert, assert
// - gas refund, state updates are reverted
// customer error - save gas
contract Error {
    // require used to test input validation and access control
    function testRequire(uint _i) public pure {
        require(_i <= 10, "_i > 10"); //21614 gas
        // if passes, more code
    }

    // equal to code above
    function testRevert(uint _i) public pure {
        if (_i > 10) {
            revert("i > 10"); //21614 gas
        }
        // if passes, more code
    }

    // revert better when you have nested if statements
    function testRevert2(uint _i) public pure {
        if (_i > 1) {
            // code
            if (_i > 2) {
                // more code
                if (_i > 10) {
                    revert("i > 10");
                }
            }
             
        }
        
    }

    // assert is used to check for condition that should always be true; if false you have a bug somewhere
    uint public num = 123;

    function testAssert() public view {
        assert(num ==123);
    }

    // custom errors are used to save gas, available using solidity ^0.8.0
    // the longer the error message the more gas that's used
    // right now custom error can only be used with revert
    // first declare error
    error MyError(address caller, uint i);

    function testCustomError(uint _i) public view {
        if (_i > 10) {
            revert MyError(msg.sender, _i);
        } 
        // if passes, more code
    }
}