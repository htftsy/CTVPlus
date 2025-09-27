import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

# Different from the paper (indexing from 1):
#	we index from 0

K0 = tx_load("K0.json") #0
K1 = tx_load("K1.json") #1
K2 = tx_load("K2.json") #2
K3 = tx_load("K3.json") #2

(G, res0, resCount) = process_tx([], K0, 0)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, K1, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, K2, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, K3, resCount)
print(res3, resCount)

"""
Execution Results:
---------
Tx | Acc.
---------
K0 | 3189
K1 | 10326
K2 | 17463
K3 | 24600
"""
