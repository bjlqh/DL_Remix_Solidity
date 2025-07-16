// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ITokenReceiver.sol";


contract MyToken is ERC20 {

    uint private _totalSupply = 100 * 10 ** decimals();
    
    constructor() ERC20("MyToken", "MT") {
        _mint(msg.sender, _totalSupply);
    }

    event TransferContract(address recipient, uint256 amount);

    function transferWithCallback(address recipient, uint256 amount, bytes calldata data) external returns (bool){
        _transfer(msg.sender, recipient, amount);
        //如果recipient是合约地址
        if(isContract(recipient)){
            bool rv = ITokenReceiver(recipient).tokensReceived(msg.sender,amount, data);
            require(rv, "No tokensReceived");
        }
        return true;
    }

    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }
}