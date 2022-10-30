// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// return multiple outputs
// named outputs
// destructuring assignment

contract FunctionOutputs {
    // return multiple outputs
    // visibility is public due to calling function within contract
    // read only and doesn't access state or global vars - so type pure

    // ----------------all three following functions do same thing ----------------
    
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    // helps with readability of data types
    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // saves a little gas
    function assigned() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
    }

    // destructuring assignment
    // function calls returnMany() function
    // capture multiple outputs and assign to variable
    function destructuringAssignments() public pure {
        (uint x, bool b) = returnMany();
        // if you only need one of the outputs simply omit keeping comma
        (, bool _b) = returnMany();
    }


}