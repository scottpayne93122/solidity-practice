// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract EventMessage {
    // create an event log that tracks a message and a value
    event Log(string message, uint val);
    // create an event IndexedLog that indexes an address of sender and also has a value
    event IndexedLog(address indexed sender, uint val);
    // create a function example that emits the log event and initializes a message and value
    function example() external {
        emit Log("test message", 123);
        // in the same function emit Indexed log and initialize sender address and value
        emit IndexedLog(msg.sender, 456);
    }
   // create an event Message with 3 parameters _from, _to, and message, index _from and _to
   event Message(address _from, address _to, string message);
   // create a function sendMessage() that takes two arguments _to and message, the message argument is a dynamic variable so use calldata as memory type     
   function sendMessage(address _to, string calldata message) external {
       emit Message(msg.sender, _to, message);
   }
}
    
    
    
