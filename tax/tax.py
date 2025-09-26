import sys
import os
sys.path.append(os.path.abspath(".."))

from evalTx import eval_bexpr, process_tx
import json
import time

# Different from the paper, we index from 0, hence the RI is:
# inp_1 bot /\ oup_3 bot /\ oup_1 RI /\ 9 * om_2 = om_0 /\ oup_3 y_1 = RECEIVER

with open("K0.json") as f:
   K0 = json.load(f)

with open(K0["RIurl"]) as f:
   K0["RI"] = json.load(f)

tx1 = K0

(G, res, resCount) = process_tx([], tx1)
print(res, resCount)

print(eval_bexpr([tx1], tx1, tx1["RI"]))

# json_data = json.dumps(data["lhs"], separators=(",", ":"))

"""Execution Results:"""

""""""