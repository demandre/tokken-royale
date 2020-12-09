pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./ElectionFactory.sol";

contract ElectionHelper is ElectionFactory {
    function startElection(uint electionId) external onlyOwnerOf(electionId) {
        require(elections[electionId].isRunning == false);
        elections[electionId].isRunning = true;
        Election storage election = elections[electionId];
        for (uint i = 0; i < election.participantIds.length; i++) {
            Vote memory vote = Vote(election.participantIds[i], 0, 0, 0);
            for (uint j = 0; j < election.participantIds.length; j++) {
                if (i != j) {
                    vote.participantTwo = election.participantIds[j];
                    uint id = elections[electionId].votesIds.length;
                    elections[electionId].votesIds.push(id);
                    elections[electionId].votes[id] = vote;
                }
            }
        }
    }

    function stopElection(uint electionId) external onlyOwnerOf(electionId) {
        require(elections[electionId].isRunning == true);
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
            for (uint j = 0; j < election.votesIds.length; j++) {
                uint voteId = election.votesIds[j];
                if (results[i].winnerId == election.votes[voteId].participantOne && results[i].loserId == election.votes[voteId].participantTwo) {
                    election.votes[voteId].countParticipantOne++;
                } else if (results[i].winnerId == election.votes[voteId].participantTwo && results[i].loserId == election.votes[voteId].participantOne) {
                    election.votes[voteId].countParticipantTwo++;
                }
            }
        }
        election.voters[msg.sender].vote = true;
    }
}
