// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

abstract contract Test {
    function register() public virtual;
    function voteFor(address) public virtual;
    function numberOfVotesReceivedFor(address) view public virtual returns(uint256);
    function winnersAndNumberOfWinningVotes() view public virtual returns(address[] memory, uint256);
}

contract Voting is Test {

    mapping(address => bool) public registered;

    mapping(address => bool) public hasVoted;

    mapping(address => uint256) private votesReceived;


    address[] private registeredList;


    function register() public override {
        require(!registered[msg.sender], "Already registered");
        registered[msg.sender] = true;
        registeredList.push(msg.sender);
    }

    function voteFor(address candidate) public override{
        require(registered[msg.sender], "Not registered");
        require(registered[candidate], "Candidate not registered");
        require(!hasVoted[msg.sender], "Already voted");
        
        hasVoted[msg.sender] = true;
        votesReceived[candidate]++;
    }

    function numberOfVotesReceivedFor(address candidate) public view override returns (uint256){
        return votesReceived[candidate];
    }

    function winnersAndNumberOfWinningVotes() public view override returns(address[] memory, uint256){
        uint256 highest = 0;
        uint256 len = registeredList.length;

        for (uint256 i = 0; i < len; i++) {
            uint256 v = votesReceived[registeredList[i]];
            if (v > highest) {
                highest = v;
            }
        }

        uint256 count = 0;
        for (uint256 i = 0; i < len; i++) {
            if (votesReceived[registeredList[i]] == highest) {
                count++;
            }
        }

        address[] memory winners = new address[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < len; i++) {
            if (votesReceived[registeredList[i]] == highest) {
                winners[index] = registeredList[i];
                index++;
            }
        }
        return (winners, highest);
    }
}
