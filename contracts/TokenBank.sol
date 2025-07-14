// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenBank is ERC20 {

    mapping (address => uint256) public balances;

    constructor() ERC20("TokenBank", "TB") {
        _mint(msg.sender, 100 * 10 ** decimals());
    }

    //记录每个地址存的数量
    function deposit(uint amount) public {
        require(amount > 0, "amount must be greater than 0");

        //从用户账户转到本合约地址
        bool success = transferFrom(msg.sender, address(this), amount);
        require(success, "failed to transferFrom");

        //记录
        balances[msg.sender] += amount;
    }

    //用户可以提取自己存的token
    function withdraw(uint amount) public {
        require(amount > 0, "amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient Balance");

        balances[msg.sender] -= amount;
        bool succ = transfer(msg.sender, amount);

        require(succ, "failed to transfer");
    }

    //查看授权额度
    function checkAllowance(address owner, address spender) public view returns (uint) {
        return allowance(owner, spender);
    }

}