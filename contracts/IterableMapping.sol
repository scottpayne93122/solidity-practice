// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// Typically you aren't able to iterate through mappings or look up certain key value pairs. This is how. 
// You can get the size of the mapping here and get all elements. 
// You're going to have to use a for loop so it's gas heavy if mapping is large

// [X] TODO: balances mapping
// [X] TODO: mapping checking to see if key is inserted
// [X] TODO: array that keeps track of address keys
// [X] TODO: function that sets the balance of the mapping balances, checks to see if key is inserted, and pushes to end of keys array
// [X] TODO: function that gets the size of the mapping and returns it
// [X] TODO: function that gets the first address and returns the balances in the keys array
// [X] TODO: function that gets the last address and returns the balances in the keys array
// [X] TODO: function the gets the i address and returns the balances in the keys array

contract IterableMapping {
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint _val) external {
        balances[_key] = _val;

        if(!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function getFirst() external view returns (uint) {
        return balances[keys[0]];
    }

    function getLast() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    function getI(uint _i) external view returns (uint) {
        return balances[keys[_i]];
    }
}