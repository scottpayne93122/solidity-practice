// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

// Structs are used to group data together
// you can use structs in state variables
// [x] TODO: create a struct Car that holds model:, year, and owner data
// [x] TODO: assign struct to different state variables types as examples
// [x] TODO: show three different ways to initialize structs by adding three different cars with important info
// [x] TODO: add three initialized structs to cars array explicitly by adding to memory and saving to state variable array
// [x] TODO: add fourth car to cars array in one line of code 
// [x] TODO: get first car from cars array and return custom data in struct and save to storage
// [x] TODO: update frist car in array year 
// [x] TODO: reset car owner of first car in array to default value using the delete keyword
// [x] TODO: reset car struct to default values for second element in cars array
// [x] TODO: do all of this in a single function called example

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function example() external {
        Car memory toyota = Car("toyota", 1990, msg.sender);
        Car memory lambo = Car({ model: "lamboorghini", year: 2000, owner: msg.sender });
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2002;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("ferrari", 2012, msg.sender));

        Car storage _car = cars[0];
        _car.year = 1999;
        delete _car.owner;

        delete cars[1];

    }

}