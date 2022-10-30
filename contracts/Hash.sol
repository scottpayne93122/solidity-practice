// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*
CREATING A CRYPTOGRAPHIC HASH FUNCTION USING keccak256

Main uses
- assign a signature
- create a unique id
- create a contract that's protected from front running --> commit/reveal scheme
*/
// Basically it takes whatever you input to it and encodes it and spits out a hash
// an output of a keccak256 hash function is bytes32

contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    /*
    DIFFERENCE B/T abi.encodePacked and abi.encode ------------------
    there's a situation called a HASH COLLISION - the inputs are different but hashes to the same output
    
    abi.encode --> encodes data into bytes
    
    abi.encodePacked --> encodes data into bytes and compresses it
        --> output is smaller
        --> omits some of the info that would be contained in abi.encode

    HASH COLLISIONS HAPPEN WHEN TWO DYNAMIC VARIABLE TYPES ARE DIRECTLY NEXT  TO ONE ANOTHER
        ex. 
        function hash(string memory text0, string memory text1) external pure returns (bytes32) {
            return keccak256(abi.encodePacked(text0, text1));
        }

        to AVOID 
            1. use abi.encode instead of encode packed
            2. or, if you're able split the dynamic data types with another data type
                ex.
                function hash(string memory text0, uint num, string memory text1) external pure returns (bytes32) {
                    return keccak256(abi.encodePacked(text0, num, text1));
                }
    */
}