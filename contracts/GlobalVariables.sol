// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract GlobalVariables {
    
    function globalVars() external view returns(address, uint, uint) { // view is different than pure in that it can read state variables and global variables
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}