// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// How to call functions from another contract

contract TestContract{
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return(x, value);
    }
}

contract CallTestContract{
    function setX(address _testContractAddr, uint _x) external {
        TestContract(_testContractAddr).setX(_x);
    }

    function getX(address _testContractAddr) external view returns (uint x) {
        x = TestContract(_testContractAddr).getX();
    }

    function setXandSendEther(address _testContractAddr, uint _x) external payable {
        TestContract(_testContractAddr).setXandReceiveEther{ value: msg.value }(_x);
    }

    function getXandValue(address _testContractAddr) external view returns (uint x, uint value) {
        (x, value) = TestContract(_testContractAddr).getXandValue();
    }
}