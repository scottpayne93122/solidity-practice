// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// [x] TODO: define an enum Status that has different states of shipping
// [x] TODO: assign enum to different types of state variables as examples
// [x] TODO: create a function get() that returns enum saved as state variable
// [x] TODO: create a function set() that sets status by enum index number (remember starts at 0)
// [x] TODO: create a ship() function that sets status as shipped
// [x] TODO: create a reset function that sets the status to default value (first in enum order)


contract Enums {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Cancelled
    }

    // state variable that holds the enum --> only state variable used in functions below
    Status public status;
    
    // a struct that holds the state variable status that holds the enum Status
    struct Order {
        address buyer;
        Status status;
    }

    // an array that holds the struct Order that holds the SV status that holds the enum Status
    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function shipped() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status;
    }
}