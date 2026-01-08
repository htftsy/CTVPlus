import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

B = tx_load("B.json") # the input of K0
K0 = tx_load("K0.json") #0
K1 = tx_load("K1.json") #1
K2 = tx_load("K2.json") #2
K3 = tx_load("K3.json") #3
K4 = tx_load("K4.json") #4
K5 = tx_load("K5.json") #5
K6 = tx_load("K6.json") #6

(G, res0, resCount) = process_tx([], B, 0)

(G, res0, resCount) = process_tx(G, K0, resCount)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, K1, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, K2, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, K3, resCount)
print(res3, resCount)

(G, res4, resCount) = process_tx(G, K4, resCount)
print(res4, resCount)

(G, res5, resCount) = process_tx(G, K5, resCount)
print(res5, resCount)

(G, res6, resCount) = process_tx(G, K6, resCount)
print(res6, resCount)


"""
Execution Results:
---------
Tx | Acc.
---------
K0 | 3032
K1 | 9483
K2 | 15934
K3 | 22385
K4 | 25804
K5 | 29223
K6 | 32642
"""
