// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract latTwoAsset {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    constructor(string memory _name, string memory _symbol, uint256 _supply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _supply;
        balanceOf[msg.sender] = _supply;
    }

    function transfer(address to, uint256 amount) external returns (bool) { 
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}

/*
Execution (rather than tx or total) cost only:
U1: 470088 (constructor)
V1: 28815 (transfer)
V2 + U2: 28815 (transfer)
V3 + U3: 28815 (transfer)
V4: 28815 (transfer)

Accumulation:
U1: 470088
V1: 498903
V2 + U2: 527718
V3 + U3: 556533
V4: 585348
*/