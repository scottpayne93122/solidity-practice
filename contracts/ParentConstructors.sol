// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 2 ways to call parent constructors
// order of initialization

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// first way to call parent constructor --> static constructor input
// plug some parenthesis behind child contract and place input
contract U is S("s"), T("t") {
}

// second way is if the inputs to the constructor are dynamic then...

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// you can also do it as a combo between static and dynamic inputs to constructor of derived contract

contract V0 is S, T("ttt") {
    constructor(string memory _name) S(_name) {
        
    }
}