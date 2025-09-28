// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFund {
    address public owner;
    uint public goal;
    uint public totalFunds;
    mapping(address => uint) public contributions;

    constructor(uint _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // Function 1: Contribute to campaign
    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        contributions[msg.sender] += msg.value;
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

    // Function 4: Check contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function 5: Refund contributors if goal not reached
    function refund() public {
        require(totalFunds < goal, "Goal was reached, no refunds");
        uint amount = contributions[msg.sender];
        require(amount > 0, "No contributions to refund");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
