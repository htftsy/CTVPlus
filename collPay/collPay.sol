// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract collPay {
    address private owner;
    uint256 public aggregator;
    uint32 public amountTotal;
    uint256 public base;

    constructor(uint256 _aggregator, uint256 _base) { // K0
        owner = msg.sender;
        amountTotal = 3;
        aggregator = _aggregator;
        base = _base;
    }

    function charge() public payable {    // K0
        require(msg.value >= 3);
    }

    function recvMoney(     // K0, K1, K2, K3
        uint256 wit
    ) public payable {
        require(amountTotal > 0);
        require(base ** (uint256(uint160(msg.sender)) * wit) == aggregator);
        
        payable(msg.sender).transfer(1);
        amountTotal --;
    }
}
/*
Execution (rather than tx or total) cost only:
K0: 347532 (constructor) + 166 (charge) + 17614 (sendMoney)
K1: 17614 (sendMoney)
K2: 17614 (sendMoney)
K3: 17614 (sendMoney)

Accumulation:
K0: 347532+166+17614 = 365312
K1: 382926
K2: 400540
K3: 418154
*/