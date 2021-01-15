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
        elections[electionId].participantIds.push(msg.sender);
        elections[electionId].participants[msg.sender].firstName = firstName;
        elections[electionId].participants[msg.sender].lastName = lastName;
        elections[electionId].participants[msg.sender].age = age;
        elections[electionId].participants[msg.sender].validated = false;
    }

    function validateParticipant(uint electionId, address participantAddress) external onlyOwnerOf(electionId) {
        uint id = elections[electionId].addressToParticipant[participantAddress];
        elections[electionId].participants[id].validated = true;
    }

    function addVoter(uint electionId, address voterAddress) external onlyOwnerOf(electionId) {
        elections[electionId].voters[voterAddress] = VoterStatus(true, false);
    }

    function addElection(string calldata title, string calldata imageUrl) external {
        _createElection(title, imageUrl);
    }

    function vote(uint electionId, Fight[] calldata results) external onlyVoterOf(electionId) hasNotVoted(electionId) {
        Election storage election = elections[electionId];

        Fight[] memory alreadyDone = new Fight[](results.length);
        for (uint i = 0; i < results.length; i++) {
            // Vérifier si les candidats si candidats existent && si le fight a déjà été effectué pour ce vote
            if(election.participants[results[i].loserId].validated && election.participants[results[i].winnerId].validated && !_checkFightPair(alreadyDone, results[i])){
                alreadyDone[i] = results[i];
                for (uint j = 0; j < election.votesIds.length; j++) {
                    uint voteId = election.votesIds[j];
                    if (results[i].winnerId == election.votes[voteId].participantOne && results[i].loserId == election.votes[voteId].participantTwo) {
                        election.votes[voteId].countParticipantOne++;
                    } else if (results[i].winnerId == election.votes[voteId].participantTwo && results[i].loserId == election.votes[voteId].participantOne) {
                        election.votes[voteId].countParticipantTwo++;
                    }
                }
            }
        }
        election.voters[msg.sender].vote = true;
    }

    function getAllElections() public view returns(ElectionDTO[] memory, ParticipantDTO[] memory){
        ElectionDTO[] memory electionDTOs = new ElectionDTO[](elections.length);
        ParticipantDTO[] memory participantDTOs = new ParticipantDTO[](1);        
        for (uint i = 0; i < elections.length; i++) {
            for (uint j = 0; j < elections[i].participantIds.length; j++) {
                Participant memory participant = elections[i].participants[elections[i].participantIds[j]];
                if(!elections[i].isOpen && !participant.validated) {
                    continue;
                }
                participantDTOs[elections[i].participantIds[j]] = ParticipantDTO(i, participant.firstName, participant.lastName, participant.age, participant.imageUrl);
            }
            electionDTOs[i] = ElectionDTO(elections[i].title, elections[i].isRunning, elections[i].isOpen, elections[i].imageUrl);
        }
        return (electionDTOs, participantDTOs);
    }


}

