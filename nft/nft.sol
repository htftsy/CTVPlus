// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract NFT {
    mapping(uint256 => address) public owner;

    function mint(uint256 id) external {
        require(owner[id] == address(0));
        owner[id] = msg.sender;
    }

    function transfer(uint256 id, address to) external {
        require(owner[id] == msg.sender);
        owner[id] = to;
    }
}

/*
Execution (rather than tx or total) cost only:
K0: 186030 (constructor) 
K1: 22863 (mint)
K2: 22863 (mint)
K3: 6026 (transfer)
K4: 6026 (transfer)
K5: 6026 (transfer)
K6: 6026 (transfer)

Accumulation:
K0: 186030
K1: 208893
K2: 231756
K3: 237782
K4: 243808
K5: 249834
K6: 255860
*/