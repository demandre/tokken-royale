pragma solidity ^0.4.4;

import "./ElectionFactory.sol";

contract ElectionHelper is ElectionFactory {
    function startElection(uint electionId) external onlyOwnerOf(electionId) {
        elections[electionId].isRunning = true;
    }

    function stopElection(uint electionId) external onlyOwnerOf(electionId) {
        _stopElection(electionsId);
    }

    function participateInElection(uint electionId, string firstName, string lastName, uint age, string imageUrl) external {
        Participant p = Participant(firstName, lastName, age, imageUrl, true, false);
        uint id = elections[electionId].participants.push(p) - 1;
        elections[electionId].addressToParticipant[msg.sender] = id;
    }

    function validateParticipant(uint electionId, address participantAddress) external onlyOwnerOf(electionId) {
        uint id = elections[electionId].addressToParticipant[participantAddress];
        elections[electionId].participants[id].validated = true;
    }

    function addVoter(uint electionId, address voterAddress) external onlyOwnerOf(electionId) {
        elections[electionId].voters[voterAddress] = true;
    }

    function vote(uint electionId, Fight[] results) external onlyVoterOf(electionId) hasNotVoted(electionId) {
        election = elections[electionId];
        // TODO: Results validation
        for (uint i = 0; i < results.length; i++) {
            election.votes[results[i]]++;
        }
        election.voters[msg.sender].vote = true;
    }
}