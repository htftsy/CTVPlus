CTV$^+$: Recursive Modal Invariants for Enforcing End-to-End Multi-Step UTXO Token Flows
==

Structure
-
'/CoqVrf' includes the Coq proof files. Soundness is proved in '/CoqVrf/innerLogic.v' (Version: *8.19*, *MacOS-arm64*)

'/evalTx.py' is a prototype interpreter for our DSL (Python *3.13.2*). To facilitate comparisons with EVM, it also returns the execution cost in gas price (according to the Ethereum gas specification).

Each other folder (say, '/hashVote') studies one application:
* 'RI.json' is the abstract syntax tree (AST) of a recursive invariant (RI) in our DSL
* 'K0.json' -- 'K3.json' stand for transactions (named by demonstrative figures of the paper)
* 'hashVote.py' verifies the transactions against their RIs and summarize the (accumulative) costs
* 'hasVote.sol' implements the same application via Ethereum smart contracts

See more details in the research paper.
