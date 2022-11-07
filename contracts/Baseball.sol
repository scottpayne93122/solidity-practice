// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


contract Baseball {
    uint public inning = 1;
    address public home = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public homeScore;
    uint public visitorScore;
    address public visitor = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public winner;
    bool public gameOver;
    Outs public outs;
   
    enum Outs {
        zero,
        one,
        two
    }

    modifier gameOn() {
        require(!gameOver, "Game is Over");
        _;
    } 

    function score() public view returns(uint, uint) {
        return (visitorScore, homeScore);
    }

   function newInning() public gameOn {
       if (inning >= 9 && visitorScore != homeScore) {
            declareWinner();
        } else {
            outs = Outs.zero;
            inning ++;
       }
       
   }

   function setInning(uint _inn) public {
       inning = _inn;
       gameOver = false;
   }

    
    function recordOut() public gameOn {
        if (outs != Outs.two) {
            outs = Outs(uint(outs) + 1);
     
        } else {
            newInning();
        }
    }

    function addRunsForHome(uint _amount) public gameOn {
        homeScore += _amount;
    }

    function addRunsForVisitor(uint _amount) public gameOn {
        visitorScore += _amount;
    }


    function declareWinner() public gameOn {
        require(homeScore != visitorScore, "Game is tied");
        if (homeScore > visitorScore) {
            winner = address(home);
        } else {
            winner = address(visitor);
        }
        gameOver = true;
    }




}