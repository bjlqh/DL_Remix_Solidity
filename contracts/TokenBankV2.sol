// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenBank.sol";
import "./ITokenReceiver.sol";


contract TokenBankV2 is TokenBank, ITokenReceiver{

    address private tokenAddress;
    
    constructor(address _tokenAddress) TokenBank(_tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    event Recevied(address indexed sender, bytes indexed data);
    function tokensReceived(address spender, uint amount, bytes memory data) external returns (bool){
        emit Recevied(spender, data);
        require(msg.sender == tokenAddress, "unauthorized contract!");
        balances[spender] += amount;
        return true;
    }

}