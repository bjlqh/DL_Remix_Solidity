// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "./IBank.sol";

contract Admin {
    
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    //将bank合约内的资金转移到admin合约地址。
    function adminWithdraw(IBank bank) external OnlyOwner {
        bank.withdraw();
    }

    modifier OnlyOwner() {
        require(msg.sender == owner, "Not the owner.");
        _;
    }

    receive() external payable {}

    //提现
    function ownerWithdraw() public OnlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}