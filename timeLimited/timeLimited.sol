// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract timeLimited {
    address private owner;
    uint256 public expTime;
    uint256 public prevTxTime;

    constructor(uint256 _expTime) { // K0
        owner = msg.sender;
        expTime = _expTime;
        prevTxTime = block.timestamp;
    }

    function charge() public payable {
        require(msg.value >= 1);
    }

    function send(address payable addr, uint256 amount) public {   // K0 K1 K2 K3
        require(msg.sender == owner);
        if(block.timestamp < expTime)
            require(block.timestamp - prevTxTime >= 0);
        addr.transfer(amount);
        prevTxTime = block.timestamp;
    }
}

/*
Execution (rather than tx or total) cost only:
K1: 229700 (constructor) 
K2: 19581 (send)
K3: 19581 (send)
K4: 19581 (send)
K5: 19581 (send)
K6: 19581 (send)
K7: 19372 (send)
K8: 19372 (send)

Accumulation:
K0: 229700
K1: 249281
K2: 268862
K3: 288443
K4: 308024
K5: 327605
K6: 347186
K7: 366558
K8: 385930
*/