// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable{}

    function withdraw(uint _amount) external {
        require(owner == msg.sender, "only owner has permission to withdraw funds");
        // below you could also use owner.transfer(_amount); but it uses less gas if you don't call a state variable,
        // and use global variable instead with payable keyword
        payable(msg.sender).transfer(_amount);
    }

    function balanceOf() external view returns(uint) {
        return address(this).balance;
    }

}