// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*
A calls B, sends 100 wei,
    B calls C, sends 50 wei
A --> B --> C
            Inside of C...
            msg.sender = B
            msg.value = 50 wei
            execute code on C's state variables
            use ETH in C

delegateCall is going to execute the code inside of the contract being called

other example...
A calls B, sends 100 wei
    B delegatecall C
A --> B --> C
        msg.sender = A
        msg.value = 100 wei
        execute code on B's state variables
        use ETH in B
*/
contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

/*
DelegateCall will call TestDelegateCall and will use TestDelegateCall's
function setVars to update DelegateCall's state variables 

since we're delegating the call to TestDelegateCall the state variables inside
of TestDelegateCall will not be updated, but state variables inside of DelegateCall will

IMPORTANT - when using delegate call to update state variables both contracts
MUST have the exact same state variables in the same order to work properly

you can however append an additional state variable after the original order and delegatecall will
work properly

*/
contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;
    
    // _test is the address of TestDelegateCall
    // there are two examples below using abi.encodeWithSignature() and abi.encodeWithSelector()
    // abi.encode with selector is nice because you don't have to write out the string
    // both examples are equivalent

    function setVars(address _test, uint _num) external payable {
        // (bool success, ) = _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // );
        // require(success, "call failed");

        (bool success, bytes memory data) = _test.delegatecall(
           abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }

}