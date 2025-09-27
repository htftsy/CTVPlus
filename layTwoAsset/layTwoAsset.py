import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

# Different from the paper (indexing from 1):
#	we index from 0 in RI.json

U1 = tx_load("U1.json") #0
V1 = tx_load("V1.json") #1
V2 = tx_load("V2.json") #2
V3 = tx_load("V3.json") #3

U2 = tx_load("U2.json") #4
U3 = tx_load("U3.json") #5
V4 = tx_load("V4.json") #6

(G, res0, resCount) = process_tx([], U1, 0)
print(res0, resCount)

(G, res1, resCount) = process_tx(G, V1, resCount)
print(res1, resCount)

(G, res2, resCount) = process_tx(G, V2, resCount)
print(res2, resCount)

(G, res3, resCount) = process_tx(G, V3, resCount)
print(res3, resCount)

(G, res4, resCount) = process_tx(G, U2, resCount)
print(res4, resCount)

(G, res5, resCount) = process_tx(G, U3, resCount)
print(res5, resCount)

(G, res6, resCount) = process_tx(G, V4, resCount)
print(res6, resCount)

"""
Execution Results:
---------
Tx | Acc.
---------
U1 | 3066
V1 | 9222
V2 | 17565
V3 | 25908
U2 | 34251
U3 | 42594
V4 | 56178
"""
