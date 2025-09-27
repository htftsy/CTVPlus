// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.8.27;

contract collPay {
    address private owner;
    address payable public player0;
    address payable public player1;
    uint256 public guess0;
    uint256 public guess1;

    constructor() { // K0
        owner = msg.sender;
        guess0 = 0;
        guess1 = 0;
    }

    function guess(uint256 _guess) public payable {    // U0 U1
        require(guess1 == 0);  // no more than one guess exists
        require(msg.value >= 1 && _guess > 0);
        if(guess0 == 0) {
            guess0 = _guess;
            player0 = payable(msg.sender);
        }
        else {
            guess1 = _guess;
            player1 = payable(msg.sender);
        }
    }

    function determineWinner() public payable {   // K1
        uint256 rnd = uint256(blockhash(block.number - 1));
        uint256 diff0;
        uint256 diff1;
        if(guess0 > rnd)        // it's unsigned
            diff0 = guess0 - rnd;
        else 
            diff0 = rnd - guess0;
        if(guess1 > rnd)
            diff1 = guess1 - rnd;
        else 
            diff1 = rnd - guess1;
        
        if(diff0 <= diff1)
            player0.transfer(2);
        else
            player1.transfer(2);
    }
}

/*
Execution (rather than tx or total) cost only:
K0: 285288 (constructor) 
U0: 46888 (guess)
U1: 46878 (guess)
K1: 14238 (determineWinner)

Accumulation:
K0: 285288
U0: 332176
U1: 379054
K1: 393292
*/