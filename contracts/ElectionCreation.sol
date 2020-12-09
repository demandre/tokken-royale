pragma solidity ^0.4.4;

import "./ElectionFactory.sol";

contract ElectionCreation is ElectionFactory {
    function createElection(string title) external {
        // TODO: Add limit
        _createElection(title);
    }
}
