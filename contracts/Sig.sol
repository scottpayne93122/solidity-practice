// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*
PROCESS OF VERIFYING SIGNATURE IN SOLIDITY
0. message to sign
1. hash(message)
2. sign(hash(message), private key) | offchain
3. erecover(hash(message), signature) == signer
*/

contract VerifySignature {
    // _signer --> address we expect ecrecover to return
    function verify(address _signer, string memory _message, bytes memory _sig)
        external pure returns (bool) // if _signer matches output of ecrecover --> true
    {
        // hash the message using keccak256 --> returns bytes32 --> getMessageHash() defined below
        bytes32 messageHash = getMessageHash(_message);
        // the message that is signed is not messageHash
        // pass messageHash to getEthSignedMessageHash and assign to ethSignedMessageHash variable
        //getEthSignedMessageHash() defined below
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        // verify ethSignedMessageHash with _sig and compare w/ input _signer and return
        // we will generate _sig below
        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
        public pure returns (address)
    {
        // _split defined below
        // r,s, and v are crytographic parameters used for digital sigs
        // not a huge deal to understand them, but you need them for ecrecover

        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure 
        returns (bytes32 r, bytes32 s, uint8 v) 
    {
        // bytes32 + bytes32 + uint8 = 65 bytes --> _sig.length
        require(_sig.length == 65, "incorrect signature length");

        // _sig is a dynamic variable type --> length takes up first 32 spaces in storage
        // _sig is not the signature, it's a pointer to the signature in memory
        // we need to assign and load to memory r,s, and v using assembly and mload()
        assembly {
            // add/skip the length 32 to the pointer of _sig before assigning r
            // r is 32 bytes in length also so add/skip 64 bytes then assign s
        
            r := mload(add(_sig, 32))
            s := mload(add(_sig,64))
            v := byte(0, mload(add(_sig, 96))) // since we only need the first byte after 96
        }

    }
}  

/*
HOW TO TEST IN REMIX -------------------------
see https://www.youtube.com/watch?v=vYwYe-Gv_XI&list=PLO5VPQH6OWdVQwpQfw9rZ67O6Pjfo6q-p&index=48
skip to 10:36
*/