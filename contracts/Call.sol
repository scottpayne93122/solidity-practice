// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// this is how to use call to call other functions in another contract
// there are two contracts below Call will be calling TestCall and using it's functions
// _test is the address of contract TestCall
// using a low level interaction like call you need to encode the function that you're passing 
// from TestCall suing the keyword abi.EncodeWithSignature(appropriate inputs required by function go here) 
// first input inside abi.EncodeWithSignature is function name, followed by parenthesis, inside of quotes
// the following inputs inside of parenthesis are the functions parameters --> important there are no spaces between parameters
// if a function input is of type uint it's important that you explicitly type uint256
// after that the next inputs are the actual arguments you want to pass in surrounded by parenthesis
// call returns two outputs --> first is a bool that tells us if call was successful or not
// the second is any output returned by the function being called, and that will be encoded with bytes
// using call you can specify the amount of Ether and gas by using curly braces after call
// after call you need to require that it was successful
// in order to see data call returned we will create a state variable of type bytes which will be public
// we will then demonstrate how the fallback function works by calling a function that doesn't exist in TestCall and emit an event 
// that logs the fact that the fallback function was executed

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return(true, 999);
    }
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111}(
            abi.encodeWithSignature(
                "foo(string,uint256)", "call with foo", 123
            )
        );
        require(success, "call failed");
        data = _data;
    }

    // remember this is purposely calling a function that deosn't exist inside TestContract
    // so the transaction should succeed and allow you to send ether even though that function doesn't exist

    function doesNotExist(address _test) external payable {
        (bool success, ) = _test.call(abi.encodeWithSignature("doesNotExist()"));
        require(success, "call failed");
    }
}