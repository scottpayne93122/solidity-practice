// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// array - dynamic or fixed size
// initialization
// insert (push), get, delete, pop, length
// creating an array in memory
// returning an array from function

contract Array {
    // dynamic - size can change
    uint[] public nums;
    // fixed - size specified in brackets
    uint[3] public numsFixed;

    // initialize array
    uint[] public numsInit = [1, 2, 3]; //setting first three values of dynamic array
    uint[3] public numsFixedInit = [4, 5, 6]; // array length must match fixed size

    
    function examples() external {
        // insert 4 into nums array, pushes to end of array, can't do with fixed array
        nums.push(4); // nums array should now be [1,2,3,4]

        // get first element of nums array and assign to local variable x
        uint x = nums[1]; // should be 1

        // update 3rd element in nums array from 3 to 777 - remember index starts at 0
        nums[2] = 777; // should be [1,2,777,4]

        // delete element at index 1 from array - element resets to default, which is 0 for uints
        // length of array stays the same
        delete nums[1]; // should be [1,0,777,4]

        // shrink the size of the array using pop, removes last element from array
        nums.pop(); // should be [1,0,777]

        // find out how long the array is and assign to var
        uint len = nums.length;

        // create an array in memory
        // push and pop are not available in arrays stored in memory
        // must have a fixed size
        uint[] memory a = new uint[](5); //creates a new array stored in memory with fixed size of 5
        //update value at index 1 to 123
        a[1] = 123;
    }

    // return array from a function
    // not recommended, gas heavy
    // this compies state variable nums to memory and returns it
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}

