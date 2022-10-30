// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract IfElse {
    function example(uint _x) external pure returns (uint) {
        if(_x < 10) {
            return 1;
        } else if (_x < 20) {
            return 2;
        }       
        return 3; // you don't have to explicitly write else      
    }

    // you can also use a TERNARY if else statement which is just shorthand
    // ternary statements are typically better for short if/else statements

    function ternary(uint _x) external pure returns (uint) {
        // if(_x < 10) {
        //     return 1; {
        // }
        // return 2;
        return _x < 10 ? 1 : 2;
    }
}