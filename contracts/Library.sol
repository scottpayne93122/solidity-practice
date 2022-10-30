// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*
Libraries allow you to separate and reuse code
They also allow you to enhance data types

We will use a library -> Math, to execute a function -> testMax(), inside of contract -> Test

Library RESTRICTIONS:
- you cannot declare state variables inside of Library
-

we will write a function inside of our library called max
we will declare max() as internal so it's embedded inside of Test contract
    you can declare it as public, but you would have to deploy it separately 
*/

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        // using ternary if expression
        // if x is greater than or equal to y then return x else return y
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x,y);
    }
}

/*
USING LIBRARIES WITH STATE VARIABLES
- create library --> ArrayLib
    - Holds function find()
    - find() takes two inputs --> arr array and x
        - runs a for loop util arr[i] == x
        - once it finds x it will return the index where x is stored
        - if it doesn't find x it will revert
*/

library ArrayLib {
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for(uint i = 0; i <= arr.length; i++ ) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    // You can also enhance a state variable data type by the following:
    using ArrayLib for uint[];
    uint[] public arr = [3,2,1];

    // find the index of 2 stored inside the array --> should return 1
    function testFind() external view returns (uint i) {
        return arr.find(2);
    }
}