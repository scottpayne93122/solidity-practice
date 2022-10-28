// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// more gas efficent than shift
// start with [1,2,3,4] -- remove(1) --> [1,4,3]
// [1,4,3] -- remove(2) --> [1,4]
// array order not preserved like in array shift

contract ArrayReplaceLast {
    uint[] public arr;

    function remove(uint _index) public {
        // replace _index element with last element in array
        arr[_index] = arr[arr.length - 1];
        // remove last element
        arr.pop();
    }

    // external because of state var modification
    function test() external {
        // initialize array
        arr = [1,2,3,4];
        // call remove()
        remove(1);

        // [1,4,3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);

        // [1,4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}