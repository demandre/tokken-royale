pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./Ownable.sol";

contract ElectionFactory is Ownable {

    struct Participant {
        string firstName;
        string lastName;
        uint age;
        string imageUrl;
        bool validated;
    }

    struct Fight {
        address winnerId;
        address loserId;
    }

    struct Vote {
        address participantOne;
        address participantTwo;
        uint countParticipantOne;
        uint countParticipantTwo;
    }

    struct VoterStatus {
        bool canVote;
        bool vote;
    }

    struct Election {
        string title;
        bool isRunning;
        bool isOpen;
        string imageUrl;
        address [] participantIds;
        mapping(address => Participant) participants;
        uint[] votesIds;
        mapping(uint => Vote) votes;
        mapping(address => VoterStatus) voters;
        mapping(address => uint) _voteCounts;
        address winnerId;
    }

    struct ElectionDTO {
        string title;
        bool isRunning;
        bool isOpen;
        string imageUrl;
    }

    struct ParticipantDTO{
        uint idElection;
        address participantAddress;
        string firstName;
        string lastName;
        uint age;
        string imageUrl;
        bool validated;
    }

    Election[] public elections;

    mapping(uint => address) public electionToAddress;

    modifier onlyVoterOf(uint _electionId) {
        require(elections[_electionId].voters[msg.sender].canVote == true);
        _;
    }

    modifier onlyOwnerOf(uint _electionId) {
        require(msg.sender == electionToAddress[_electionId]);
        _;
    }

    modifier hasNotVoted(uint _electionId) {
        require(elections[_electionId].voters[msg.sender].vote == false);
        _;
    }

    function _createElection(string memory _title, string memory _imageUrl) internal {
        uint id = elections.push(
            Election(
                _title,
                false,
                true,
                _imageUrl,
                new address[](0),
                new uint[](0),
                address(0)
            )
        ) - 1;
        electionToAddress[id] = msg.sender;
    }

    function _stopElection(uint _electionId) internal {
        elections[_electionId].isRunning = false;
        elections[_electionId].winnerId = _stopTheCount(_electionId);
    }

    function _checkFightPair(Fight[] memory fightArray, Fight memory fight) internal returns (bool){
        for (uint i = 0; i < fightArray.length; i++) {
            if((fightArray[i].winnerId == fight.winnerId && fightArray[i].loserId == fight.loserId) || (fightArray[i].winnerId == fight.loserId && fightArray[i].loserId == fight.winnerId)){
                return true;
            }
        }
        return false;
    }

    function _stopTheCount(uint _electionId) internal returns (address) {
        Election storage election = elections[_electionId];
        address winner = address(0);
        address[] memory winners = new address[](election.participantIds.length);
        uint winnersCount = 0;
        
        for (uint i = 0; i < election.votesIds.length; i++) {
            election._voteCounts[election.votes[i].countParticipantOne > election.votes[i].countParticipantOne ? election.votes[i].participantOne : election.votes[i].participantTwo]++;
        }

        //Easy case: most wins.
        uint max = 0;
        for (uint i = 0; i < election.participantIds.length; i++) {
            if(election._voteCounts[election.participantIds[i]] > max) {
                max = election._voteCounts[election.participantIds[i]];
                winner = election.participantIds[i];
            }
        }

        for (uint i = 0; i < election.participantIds.length; i++) {
            if(election._voteCounts[election.participantIds[i]] == max){
                winners[winnersCount] = election.participantIds[i];
                winnersCount++;
            }
        }

        //Second case: if multiples winners, check if there is a male alpha who dominate the others.
        if (winnersCount > 1) {
            for (uint i = 0; i < winnersCount; i++) {
                bool isBolossed = false;
                for (uint j = 0; j < winnersCount; j++) {
                    if(i != j){
                        for (uint k = 0; k < election.votesIds.length; k++) {
                            if(election.votes[k].participantOne == winners[i] && election.votes[k].participantTwo == winners[j]){
                                if(election.votes[k].countParticipantOne <= election.votes[k].countParticipantTwo) {
                                    isBolossed = true;
                                    break;
                                }
                            } else if (election.votes[k].participantOne == winners[j] && election.votes[k].participantTwo == winners[i]){
                                if(election.votes[k].countParticipantOne >= election.votes[k].countParticipantTwo) {
                                    isBolossed = true;
                                    break;
                                }
                            }
                        }
                    }
                }
                if(!isBolossed){
                    return winners[i];
                }
            }
        }
        return winner;
    }
}
