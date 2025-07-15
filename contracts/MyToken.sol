// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    uint private _totalSupply = 1000 * 10 ** decimals();
    
    constructor() ERC20("MyToken", "MT") {
        _mint(msg.sender, _totalSupply);
    }
}