// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract tax {
    address payable public taxReceiver;
    address private owner;
    uint256 public amountTotal;

    constructor(address payable _taxReceiver) { // K0
        owner = msg.sender;
        taxReceiver = _taxReceiver;
        amountTotal = 0;
    }

    function charge() public payable {    // K0
        amountTotal += msg.value;
    }

    function sendMoney(     // K0, K1, K2, K3
        address payable target, 
        uint256 amount, 
        uint256 amountTax
    ) public {
        require(msg.sender == owner);
        require(amountTax * 9 == amount);
        require(amountTax + amount <= amountTotal);
        target.transfer(amount);
        taxReceiver.transfer(amountTax);
        amountTotal -= amountTax + amount;
    }
}
/*
Execution (rather than tx or total) cost only:
K0: 283767 (constructor) + 22429 (charge) + 79851 (sendMoney)
K1: 79851 (sendMoney)
K2: 79851 (sendMoney)
K3: 79851 (sendMoney)

Accumulation:
K0: 283767+22429+79851 = 386047
K1: 465898
K2: 545749
K3: 625600
*/