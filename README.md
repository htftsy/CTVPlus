# Recursive Invariants for Multi-Step UTXO Transactions

> ⚠️ **Research Project Disclaimer**  
> This project is for **research purposes only**. It is a prototype and not intended for production use.  

## Structure

- **`/CoqVrf`**  
  Contains the Coq proof files.  
  - Main proof of soundness: [`innerLogic.v`](CoqVrf/innerLogic.v)  
  - Verified with **Coq 8.19** on **macOS-arm64**.

- **`/evalTx.py`**  
  A prototype interpreter for our DSL, written in **Python 3.13.2**.  
  - Returns the execution cost in gas units (based on the Ethereum gas specification) for comparison with the EVM.  

- **Other application folders** (e.g., `/hashVote`)  
  Each folder demonstrates a specific application of recursive invariants (RIs):  
  - `RI.json` — the abstract syntax tree (AST) of an RI in our DSL.  
  - `K0.json` … `K3.json` — transactions (corresponding to demonstrative figures in the paper).  
  - `hashVote.py` — verifies the transactions against their RIs and summarizes cumulative costs.  
  - `hashVote.sol` — Ethereum smart-contract implementation of the same application.  

---

📖 For more details, please refer to the accompanying research paper.