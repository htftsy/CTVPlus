import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

K1 = tx_load("K1.json") #0
K2 = tx_load("K2.json") #1
K3 = tx_load("K3.json") #2
K4 = tx_load("K4.json") #3
K5 = tx_load("K5.json") #4
K6 = tx_load("K6.json") #5
K7 = tx_load("K7.json") #6
K8 = tx_load("K8.json") #7

(G, res0, resCount) = process_tx([], K1, 0)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, K2, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, K3, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, K4, resCount)
print(res3, resCount)

(G, res4, resCount) = process_tx(G, K5, resCount)
print(res4, resCount)

(G, res5, resCount) = process_tx(G, K6, resCount)
print(res5, resCount)

(G, res6, resCount) = process_tx(G, K7, resCount)
print(res6, resCount)

(G, res7, resCount) = process_tx(G, K8, resCount)
print(res7, resCount)

"""
Execution Results:
---------
Tx | Acc.
---------
K1 | 3050
K2 | 9618
K3 | 16657
K4 | 23219
K5 | 30252
K6 | 36814
K7 | 39858
K8 | 42902
"""
