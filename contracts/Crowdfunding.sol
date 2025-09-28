// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFund {
    address public owner;
    uint public goal;
    uint public totalFunds;

    constructor(uint _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // Function 1: Contribute to campaign
    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        totalFunds += msg.value;
    }

    // Function 2: Withdraw funds if goal reached
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(totalFunds >= goal, "Funding goal not reached");
        payable(owner).transfer(address(this).balance);
    }

    // Function 3: Check if goal is reached
    function isGoalReached() public view returns (bool) {
        return totalFunds >= goal;
    }
}

