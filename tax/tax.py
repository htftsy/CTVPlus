import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

# Different from the paper, we index from 0, hence the RI is:
# inp_1 bot /\ oup_3 bot /\ oup_1 RI /\ 9 * om_2 = om_0 /\ oup_2 y_0 = RECEIVER


K0 = tx_load("K0.json") #0
K1 = tx_load("K1.json") #1
K2 = tx_load("K2.json") #2
K3 = tx_load("K3.json") #3

U1 = tx_load("U1.json") #4
U2 = tx_load("U2.json") #5
U3 = tx_load("U3.json") #6

(G, res0, resCount) = process_tx([], K0, 0)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, K1, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, K2, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, K3, resCount)
print(res3, resCount)

(G, res4, resCount) = process_tx(G, U1, resCount)
print(res4, resCount)

(G, res5, resCount) = process_tx(G, U2, resCount)
print(res5, resCount)

(G, res6, resCount) = process_tx(G, U3, resCount)
print(res6, resCount)

# json_data = json.dumps(data["lhs"], separators=(",", ":"))

"""
Execution Results:
---------
Tx | Acc.
---------
K0 | 29
K1 | 402
K2 | 775
K3 | 1148
U1 | 1492
U2 | 1836
U3 | 2180
"""
