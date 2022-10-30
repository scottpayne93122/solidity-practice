// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract Mapping {
    mapping(address => uint) public balances;
    // nested mapping
    mapping(address => mapping(address => bool)) public isFriend;

    function example1() external {
        // init value of msg.sender
        balances[msg.sender] = 123;
    }

    function example2() external {
        // add to msg.sender balance
        balances[msg.sender] += 456; // 579 if you've called example(1) prior
    }

    function example3() external {
        isFriend[msg.sender][address(this)] = true;
    }
}