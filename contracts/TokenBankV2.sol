// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenBank.sol";

contract TokenBankV2 is TokenBank {

    address private tokenAddress;
    
    constructor(address _tokenAddress) TokenBank(_tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    event Recevied(address sender);

    function tokensReceived(address sender, uint amount) external returns (bool){
        emit Recevied(sender);
        require(msg.sender == tokenAddress, "unauthorized contract!");
        balances[sender] += amount;
        return true;
    }

}