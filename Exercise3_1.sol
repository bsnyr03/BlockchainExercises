// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

abstract contract Test {
    function register() public virtual;
    function voteFor(address) public virtual;
    function numberOfVotesReceivedFor(address) view public virtual returns(uint256);
}

contract Voting is Test {

    mapping(address => bool) public registered;

    mapping(address => bool) public hasVoted;

    mapping(address => uint256) private votesReceived;

    function register() public override {
        require(!registered[msg.sender], "Already registered");
        registered[msg.sender] = true;
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
}
