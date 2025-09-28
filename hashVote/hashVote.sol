// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract hashVote {
    address private owner;
    uint256 public vote0;
    uint256 public vote1;

    constructor() { // K0
        owner = msg.sender;
        vote0 = 0;
        vote1 = 0;
    }

    function vote(uint256 _nonce, bool v) public {   // K0 K1 K2 K3
        require(keccak256(abi.encodePacked(msg.sender, _nonce)) < bytes32(uint256(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)));
        if(v)
            vote1 ++;
        else 
            vote0 ++;
    }
}

/*
Execution (rather than tx or total) cost only:
K0: 246451 (constructor) + 23506 (vote)
K1: 23506 (vote)
K2: 23506 (vote)
K3: 23506 (vote)

Accumulation:
K0: 269957
K1: 293463
K2: 316969
K3: 340475
*/