// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// Create 2 contracts A(parent) and B(child)
// In contract A create 2 functions foo() and bar() that return a simple string
// Allow functions from contract a to be customizable in contract b using the virtual keyword
// In contract B allow foo() and bar() to be cutomized using override keyword
// In contract A create a third function baz() that isn't customizable in contract B
// Create a 3rd contract C that inherits from B and has one customizable function bar()
// in order to let bar() be customizeable in contract C add the virtual keyword

contract A {
    function foo() external pure virtual returns (string memory) {
        return "A";
    }
    function bar() external pure virtual returns (string memory) {
        return "B";
    }
    function baz() external pure returns (string memory) {
        return "C";
    }

}

contract B is A {
    function foo() external pure override returns (string memory) {
        return "B";
    }
    function bar() external pure virtual override returns (string memory) {
        return "A";
    }
}

contract C is B {
    function bar() external pure override returns (string memory) {
        return "B";
    }
}