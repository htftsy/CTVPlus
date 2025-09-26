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

    function sendMoney(     // K1, K2, K3
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