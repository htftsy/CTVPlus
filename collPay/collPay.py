import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

# Different from the paper (indexing from 1):
#	we index from 0, hence the RI is:
#	 y_1 ^ (y_0 * y_3) = y_2 /\ oup_0 y_1 = y_1 /\ oup_0 y_2 = y_2 /\ Ver(y_0, sig_0)
#	/\ oup_0 RI(lambda_0 + 1) /\ oup_0 inp_1 Bot
#	/\ om_1 = 1

K0 = tx_load("K0.json") #0
K1 = tx_load("K1.json") #1
K2 = tx_load("K2.json") #2
K3 = tx_load("K3.json") #3

(G, res0, resCount) = process_tx([], K0, 0)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, K1, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, K2, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, K3, resCount)
print(res3, resCount)


U1 = tx_load("U1.json") #4
U2 = tx_load("U2.json") #5
U3 = tx_load("U3.json") #6
U4 = tx_load("U4.json") #6

(G, res4, resCount) = process_tx(G, U1, resCount)
print(res4, resCount)

(G, res5, resCount) = process_tx(G, U2, resCount)
print(res5, resCount)

(G, res6, resCount) = process_tx(G, U3, resCount)
print(res6, resCount)

(G, res7, resCount) = process_tx(G, U4, resCount)
print(res7, resCount)


"""
Execution Results:
---------
Tx | Acc.
---------
K0 | 3084
K1 | 9873
K2 | 16662
K3 | 23451
U1 | 27156
U2 | 30861
U3 | 34566
U4 | 37650
"""
