// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/* 
There are two ways to create a new contract in solidity create and create2 
This example explains how create is used
AccountFactory will execute a function that creates a new contract in the type of Account
We will supply AccountFactory with the owner address and ETH that it will forward to Account
Account will return the bank address as the AccountFactory contract address
Account will return the owner address as the _owner argument we passed to it

This is how you deploy contracts from another contract

Testing in Remix:
1. Deploy account factory
2. call createAccount() inserting address from first account and sending 200 wei
3. call accounts inserting 0 as first account indexed in array
4. copy that address and select the account contract to deploy
3. insert that copied address into At Address deployment option
*/



contract Account {
    address public bank;
    address public owner; 

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

// typically when contracts deploy other contracts, they're appended with Factory
contract AccountFactory {
    // create an array that holds the account addresses 
    Account[] public accounts;
    // to send ether to new contract use curly braces with value inside similar to low level call
    // when you call the createAccount function you need to send an amount of ether that's >= the 
    // value inside of the curly brackets that will then be sent to the new contract 
    function createAccount(address _owner) external payable {
        Account account = new Account{value: 111}(_owner);
        accounts.push(account);
    }
}