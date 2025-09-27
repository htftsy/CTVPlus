import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

K0 = tx_load("K0.json") #0
U0 = tx_load("U0.json") #1
U1 = tx_load("U1.json") #2
K1 = tx_load("K1.json") #3

(G, res0, resCount) = process_tx([], K0, 0)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, U0, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, U1, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, K1, resCount)
print(res3, resCount)


"""
Execution Results:
---------
Tx | Acc.
---------
K0 | 3051
U0 | 10521
U1 | 19362
K1 | 34139
"""
