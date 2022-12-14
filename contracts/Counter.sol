// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }

    // since both functions modify the state variable count they are neither view or pure
}

