// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DrugDiscoveryDAO {
    struct Discovery {
        uint256 id;
        address researcher;
        string targetGene;
        string drugCandidate;
        int256 bindingAffinity;
        uint256 timestamp;
        bool verified;
    }
    
    mapping(uint256 => Discovery) public discoveries;
    mapping(address => uint256) public tokenBalances;
    uint256 public discoveryCount;
    address public owner;
    uint256 public constant REWARD = 100;
    
    event DiscoverySubmitted(uint256 id, address researcher, string targetGene);
    event TokensMinted(address to, uint256 amount);
    
    constructor() {
        owner = msg.sender;
        tokenBalances[owner] = 10000;
    }
    
    function submitDiscovery(string memory _targetGene, string memory _drugCandidate, int256 _bindingAffinity) 
        public returns (uint256) {
        discoveryCount++;
        discoveries[discoveryCount] = Discovery(discoveryCount, msg.sender, _targetGene, _drugCandidate, _bindingAffinity, block.timestamp, false);
        tokenBalances[msg.sender] += REWARD;
        emit DiscoverySubmitted(discoveryCount, msg.sender, _targetGene);
        emit TokensMinted(msg.sender, REWARD);
        return discoveryCount;
    }
    
    function getTokenBalance(address _user) public view returns (uint256) {
        return tokenBalances[_user];
    }
    
    function getDiscovery(uint256 _id) public view returns (address, string memory, string memory, int256, uint256, bool) {
        Discovery memory d = discoveries[_id];
        return (d.researcher, d.targetGene, d.drugCandidate, d.bindingAffinity, d.timestamp, d.verified);
    }
}