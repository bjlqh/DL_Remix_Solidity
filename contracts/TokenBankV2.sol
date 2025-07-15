// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenBank.sol";

contract TokenBankV2 is TokenBank {
    
    constructor(address _tokenAddress) TokenBank(_tokenAddress) {

    }

    function tokensReceived(address sender, uint amount) external returns (bool){
        balances[sender] += amount;
        return true;
    }


}