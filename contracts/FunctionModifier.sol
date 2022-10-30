// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// function modifier - reuse code before and/or after function
// Basic, inputs, sandwich

contract FunctionModifier {
    
 // ------------------original code w/o modifier----------------   
    // bool public paused;
    // uint public count;

    // function setPause(bool _paused) external {
    //     paused = _paused;
    // }
    
    // function inc() external {
    //     require(!paused, "paused");
    //     count += 1;
    // }

    // function dec() external {
    //     require(!paused, "paused");
    //     count -= 1;
    // }

    //------------------- using modifier -----------------------

    bool public paused;
    uint public count;

    modifier notPaused() {
        require(!paused, "paused");
        _; // underscore means to run following code if modifier passes
    }

    // modifier that passes in inputs
    modifier cap(uint _x) {
        require(_x < 100, "_x > 100");
        _;
    }

    // sandwich modifier 1. modifier code 2. function code 3. modifier code

    modifier sandwich() {
        // code here
        count +=10;
        _;
        // more code here
        count *= 2;
    }

    function setPause(bool _paused) external {
        paused = _paused;
    }
    
    function inc() external notPaused {
        count += 1;
    }

    function dec() external notPaused {
        count -= 1;
    }

    // functions can have more than one modifier and can recieve inputs
    function incBy(uint _x) external notPaused cap(_x) {
        count += _x;
    }

    // function using sandwich modifier
    // if count is set at 0
    // modifier adds 10 to 0, count = 10
    // function adds 1 to 10, count = 11 
    // modifier multiplies 11 by 2
    // count should equal 22
    function sanModEx() external sandwich {
        count += 1;
    }


}