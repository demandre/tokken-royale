pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./ElectionFactory.sol";

contract ElectionHelper is ElectionFactory {
    function startElection(uint electionId) external onlyOwnerOf(electionId) {
        elections[electionId].isRunning = true;
    }

    function stopElection(uint electionId) external onlyOwnerOf(electionId) {
        _stopElection(electionId);
    }

    function participateInElection(uint electionId, string calldata firstName, string calldata lastName, uint age, string calldata imageUrl) external {
        Participant memory p = Participant(firstName, lastName, age, imageUrl, true, false);
        uint id = elections[electionId].participantIds.length;
        elections[electionId].participantIds.push(id);
        elections[electionId].participants[id] = p;

    elections[electionId].addressToParticipant[msg.sender] = id;
    }

    function validateParticipant(uint electionId, address participantAddress) external onlyOwnerOf(electionId) {
        uint id = elections[electionId].addressToParticipant[participantAddress];
        elections[electionId].participants[id].validated = true;
    }

    function addVoter(uint electionId, address voterAddress) external onlyOwnerOf(electionId) {
        elections[electionId].voters[voterAddress] = VoterStatus(true, false);
    }

    function vote(uint electionId, Fight[] calldata results) external onlyVoterOf(electionId) hasNotVoted(electionId) {
        Election storage election = elections[electionId];
        // TODO: Results validation
        for (uint i = 0; i < results.length; i++) {
            //election.votes[results[i]]++;
        }
        election.voters[msg.sender].vote = true;
    }
}