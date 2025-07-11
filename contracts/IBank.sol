// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

interface IBank {
    
    function deposit() external payable;

    function withdraw() external;
}

