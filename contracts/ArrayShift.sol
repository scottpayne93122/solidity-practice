// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// If you intend to remove an element in an array at an index that's before the last number you must shift index element to end then use pop to remove
contract ArrayShift {
    uint[] public arr;

    // using delete won't do it, we need final array of [1,3]
    function example() public {
        arr = [1, 2, 3];
        delete arr[1]; // [1,0,3]
    }

    // copies all elements to right of chosen index and shifts left then removes last element
    //[1,2,3] -- remove(1) --> [1,3,3] --> [1,3]
    //[1,2,3,4,5,6] -- remove(2) --> [1,2,4,5,6,6] --> [1,2,4,5,6]
    function remove(uint _index) public {
        // index should be less than length of array
        require(_index < arr.length, "index does not exist");

        for(uint i = _index; i < arr.length - 1; i++) {
            // copies elements from left to right from chosen _index
            arr[i] = arr[i + 1];
        }
        // removes last element in array
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // [1,2,4,5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);
    }
}