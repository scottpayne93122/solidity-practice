// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/*
2 ways to call parent functions
- direct
- super

    E
  /  \
 F    G
  \  /
    H 
*/

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        // directly call foo() from contract E using dot notation
        E.foo(); 
        // on function call - emits 2 log events F.foo and E.foo
    }

    function bar() public virtual override {
        emit Log("F.bar");
        // call bar() from contract E using super keyword
        super.bar(); 
        // on function call - emits 2 log events F.bar and E.bar
    }
}


// when only inheriting from one parent contract dot notation and super keyword return same result
contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo(); 
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar(); 
    }
}

// when inheriting from multiple parents dot notation will return from specified parent while super keyword will inherite from multiple parents
contract H is F, G {

    function foo() public override(F,G) {
        F.foo();
    } // emits "F.foo" from contract F and "E.foo" from contract E

    function bar() public override(F,G) {
        super.bar();
    } // emits "G.bar" from contract G, "F.Bar" from contract F, "E.Bar" from contract E
}