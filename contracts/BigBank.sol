// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "./Bank.sol";

contract BigBank is Bank {

    function deposit() public payable override limitAmount {
        super.deposit();
    }

    modifier limitAmount() {
        require(msg.value > 10**15, "Must send ETH");
        _;
    }

    function withdraw() public override OnlyOwner {
        super.withdraw();
    }

    //转移合约的管理员，老管理员设置新管理员
    function transferOwnership(address newOwner) external OnlyOwner {
        require(newOwner != address(0), "New owner is zero address");
        owner = newOwner;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner, "Not the owner.");
        _;
    }
}