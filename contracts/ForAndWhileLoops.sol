// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract ForAndWhileLoops {
    
    // for loops repeat a block of code a set number of times
    // the less loops you run the less gas is spent
    function loops() external pure {
        for (uint i; i < 10; i++) {
            //code
            if (i == 3) {
                continue; // continue is used to skip block of code if condition is true and move to next iteration
            }
            //more code
            if (i == 5) {
                break; // break means the loop stops once condition is true
            }
        }
        uint j = 0;
        while (j < 10) {
            // code
            j++;
        }
    }

    // practical example: given an input _n function sum() will add all numbers 1 to _n
    function sum(uint _n) external pure returns (uint) {
        uint s; //initialize variable to keep track of sum
        for (uint i = 1; i <= _n; i++) {
            s += i;
        }
        return s; // 15
    }
}