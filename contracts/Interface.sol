// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// interface allows you to call another contracts code without having 
// access to that contracts code. this example just requires the contract address

// However in this example we will deploy the contract counter.sol that we already have access to 
// in order to get a contract address in this local environment. 

// a typical example of this would be if the code is thousands of lines long, this would
// prevent you from having to copy and paste the entire file

// first thing is you have to declare the interface by using the keyword interface
// typical practice is to name the interface the same as the contract name prepended with a cap I --> ICounter

// you define what functions you'll use from the counter contract but omit the curly braces at the end

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract CallInterface {
    uint public count;
    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}