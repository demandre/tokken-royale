pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./ElectionFactory.sol";

contract ElectionCreation is ElectionFactory {
    function createElection(string calldata title) external {
        // TODO: Add limit
        _createElection(title);
    }
}
