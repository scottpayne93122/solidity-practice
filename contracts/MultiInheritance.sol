// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// Order of inheritance --> Most base like to derived

/*
   X
  / |
Y   |
 \  |
   Z
 
 X IS MOST BASELIKE, Z IS MOST DERIVED --> XYZ
*/

// order of inheritance is important

contract X {
    function foo() external pure virtual returns (string memory) {
        return "X";
    }
    function bar() external pure virtual returns (string memory) {
        return "X";
    }
    function x() external pure returns (string memory) {
        return "X";
    }
}

contract Y is X{
    function foo() external pure virtual override returns (string memory) {
        return "Y";
    }
    function bar() external pure virtual override returns (string memory) {
        return "Y";
    }
    function y() external pure returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {
    // if you're using override and inheriting from multiple contracts you need to specify those contracts
    // using () after override. The order of the parent contracts doesn't matter like it does when declaring
    // the actual contract like above
    function foo() external pure override(X, Y) returns (string memory) {
        return "Z";
    }
    function bar() external pure override(Y, X) returns (string memory) {
        return "Z";
    }
}
