// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenReceiver {
    function tokensReceived (address sender, uint amount, bytes memory data) external returns (bool);
}