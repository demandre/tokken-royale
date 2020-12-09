pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./Ownable.sol";

contract ElectionFactory is Ownable {

    struct Participant {
        string firstName;
        string lastName;
        uint age;
        string imageUrl;
        bool active;
        bool validated;
    }

    struct Fight {
        uint winnerId;
        uint loserId;
    }

    struct Vote {
        uint participantOne;
        uint participantTwo;
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
        uint[] participantIds;
        mapping(uint => Participant) participants;
        uint[] votesIds;
        mapping(uint => Vote) votes;
        mapping(address => VoterStatus) voters;
        mapping(address => uint) addressToParticipant;
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

    function _createElection(string memory _title) internal {
        uint id = elections.push(
            Election(
                _title,
                false,
                new uint[](0),
                new uint[](0)
            )
        ) - 1;
        electionToAddress[id] = msg.sender;
    }

    function _stopElection(uint _electionId) internal {
        elections[_electionId].isRunning = false;
    }
}
