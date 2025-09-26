import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx, tx_load
import json
import time

# Different from the paper, we index from 0, hence the RI is:
# inp_1 bot /\ oup_3 bot /\ oup_1 RI /\ 9 * om_2 = om_0 /\ oup_2 y_0 = RECEIVER


K0 = tx_load("K0.json")

(G, res, resCount) = process_tx([], K0)
print(res, resCount)

print(eval_bexpr([K0], K0, K0["RI"]))

# json_data = json.dumps(data["lhs"], separators=(",", ":"))

"""Execution Results:
K0
K1
K2
K3
U1
U2
U3
"""