pragma solidity ^0.4.4;
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

    struct VoterStatus {
        bool canVote;
        bool vote;
    }

    struct Election {
        string title;
        bool isRunning;
        Participant[] participants;
        mapping(Fight => uint) votes;
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

    function _createElection(string _title) internal {
        uint id = elections.push(Election(_title, false)) - 1;
        electionToAddress[id] = msg.sender;
    }

    function _stopElection(uint _electionId) internal {
        elections[_electionId].isRunning = false;
    }
}
