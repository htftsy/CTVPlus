import json
import time
import math

# Different from the paper (indexing from 1), 
# 	we index from 0, hence an exemplary RI is:
# inp_1 bot /\ oup_3 bot /\ oup_1 RI /\ 9 * om_2 = om_0 /\ oup_3 y_1 = RECEIVER

# Please refer to the Coq proof assistant file for type definitions.
# For clarity, lhs (rhs) always denotes the first (second) argument.

# gas price: https://github.com/djrtwo/evm-opcode-gas-costs/blob/master/opcode-gas-costs_EIP-150_revision-1e18248_2017-04-12.csv

def eval_aexpr(G, tx, a):
	if a["op"] == "Anum":
		return a["lhs"]
	elif a['op'] == "Aneg":
		lhs = eval_aexpr(G, tx, a["lhs"])
		if lhs == -1:
			return -1
		else:
			return 1 - lhs
	elif a['op'] == "Aadd":
		lhs = eval_aexpr(G, tx, a["lhs"])
		rhs = eval_aexpr(G, tx, a["rhs"])
		if lhs == -1 or rhs == -1:
			return -1
		else:
			return lhs + rhs
	elif a['op'] == "Asub":
		lhs = eval_aexpr(G, tx, a["lhs"])
		rhs = eval_aexpr(G, tx, a["rhs"])
		if lhs == -1 or rhs == -1:
			return -1
		else:
			return lhs - rhs
	elif a['op'] == "Amul":
		lhs = eval_aexpr(G, tx, a["lhs"])
		rhs = eval_aexpr(G, tx, a["rhs"])
		if lhs == -1 or rhs == -1:
			return -1
		else:
			return lhs * rhs
	elif a['op'] == "Apow":
		lhs = eval_aexpr(G, tx, a["lhs"])
		rhs = eval_aexpr(G, tx, a["rhs"])
		if lhs == -1 or rhs == -1:
			return -1
		else:
			return lhs ** rhs
	elif a['op'] == "Ahash1":
		return eval_aexpr(G, tx, a["lhs"]) # simulate
	elif a['op'] == "Ahash2":
		lhs = eval_aexpr(G, tx, a["lhs"])
		rhs = eval_aexpr(G, tx, a["rhs"])
		if lhs == -1 or rhs == -1:
			return -1
		else:
			return lhs + rhs
	elif a['op'] == "Aabs":
		return abs(eval_aexpr(G, tx, a["lhs"]))
	elif a['op'] == "Ainp":
		if a["lhs"] >= len(tx["in"]):
			return -1
		if tx["in"][a["lhs"]] < len(G):
			return eval_aexpr(G, G[tx["in"][a["lhs"]]], a["rhs"])
		else:
			return -1
	elif a['op'] == "Aoup":
		if a["lhs"] >= len(tx["out"]):
			return -1
		if tx["out"][a["lhs"]] < len(G):
			return eval_aexpr(G, G[tx["out"][a["lhs"]]], a["rhs"])
		else:
			return -1
	elif a['op'] == "Aomega":
		return time.time()
	elif a['op'] == "ARnd":
		return time.time()
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "AsymId":
		return tx["id"]
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymx":
		return tx["x"][a["lhs"]["n"]]
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymin":
		return tx["in"][a["lhs"]["n"]]
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymout":
		return tx["out"][a["lhs"]["n"]]
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymim":
		return tx["im"][a["lhs"]["n"]]
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymom":
		return tx["om"][a["lhs"]["n"]]
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymlam":
		return tx["lambda"][a["lhs"]["n"]]

def eval_aexpr_count(G, tx, a):
	if a["op"] == "Anum":
		return 0
	elif a['op'] == "Aneg":
		return 3 + eval_aexpr_count(G, tx, a["lhs"])
	elif a['op'] == "Aadd":
		return 3 + eval_aexpr_count(G, tx, a["lhs"]) + eval_aexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Asub":
		return 3 + eval_aexpr_count(G, tx, a["lhs"]) - eval_aexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Amul":
		return 5 + eval_aexpr_count(G, tx, a["lhs"]) + eval_aexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Apow":
		expVal = eval_aexpr(G, tx, a["rhs"])
		if expVal == 0:
			return 10 + eval_aexpr_count(G, tx, a["lhs"]) + eval_aexpr_count(G, tx, a["rhs"])
		else:
			return 10 + 10 * (1 + math.trunc(math.log(expVal))) + eval_aexpr_count(G, tx, a["lhs"]) + eval_aexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Ahash1":
		return 30 + 6 * 8 + eval_aexpr_count(G, tx, a["lhs"])
	elif a['op'] == "Ahash2":
		return 30 + 6 * 8 * 2 + eval_aexpr_count(G, tx, a["lhs"]) + eval_aexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Aabs":
		return 6 + eval_aexpr_count(G, tx, a["lhs"])
	elif a['op'] == "Ainp":
		if a["lhs"] >= len(tx["in"]):
			return 0
		if tx["in"][a["lhs"]] < len(G):
			return eval_aexpr_count(G, G[tx["in"][a["lhs"]]], a["rhs"])
		else:
			return 0
	elif a['op'] == "Aoup":
		if a["lhs"] >= len(tx["out"]):
			return 0
		if tx["out"][a["lhs"]] < len(G):
			return eval_aexpr_count(G, G[tx["out"][a["lhs"]]], a["rhs"])
		else:
			return 0
	elif a['op'] == "Aomega":
		return 2  # TIMESTAMP
	elif a['op'] == "ARnd":
		return 20 # BLOCKHASH
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "AsymId":
		return 0
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymx":
		return 3
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymin":
		return 3
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymout":
		return 3
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymim":
		return 3
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymom":
		return 3
	elif a['op'] == "Asymbol" and a["lhs"]["op"] == "Asymlam":
		return 3

def eval_gexpr(G, tx, a):
	if a["op"] == "Gnum":
		return a["lhs"]
	elif a['op'] == "Gmul":
		return eval_gexpr(G, tx, a["lhs"]) * eval_gexpr(G, tx, a["rhs"])
	elif a['op'] == "Gpow":
		return eval_gexpr(G, tx, a["lhs"]) ** eval_gexpr(G, tx, a["rhs"])
	elif a['op'] == "Ghash1":
		return eval_gexpr(G, tx, a["lhs"])
	elif a['op'] == "Ghash2":
		return eval_gexpr(G, tx, a["lhs"]) + eval_gexpr(G, tx, a["rhs"])
	elif a['op'] == "Ginp":
		if a["lhs"] >= len(tx["in"]):
			return -1
		if tx["in"][a["lhs"]] < len(G):
			return eval_gexpr(G, G[tx["in"][a["lhs"]]], a["rhs"])
		else:
			return -1
	elif a['op'] == "Goup":
		if a["lhs"] >= len(tx["out"]):
			return -1
		if tx["out"][a["lhs"]] < len(G):
			return eval_gexpr(G, G[tx["out"][a["lhs"]]], a["rhs"])
		else:
			return -1
	elif a['op'] == "Gomega":
		return time.time()
	elif a['op'] == "Gsymbol" and a["lhs"]["op"] == "GsymPk":
		return tx["y"][1]
	elif a['op'] == "Gsymbol" and a["lhs"]["op"] == "Gsigma":
		return tx["sig"][a["lhs"]["n"]]
	elif a['op'] == "Gsymbol" and a["lhs"]["op"] == "Gsymy":
		return tx["y"][a["lhs"]["n"]]

def eval_gexpr_count(G, tx, a):
	# Just assume that the cyclic group G is F_p for a prime p
	if a["op"] == "Gnum":
		return 0
	elif a['op'] == "Gmul":
		# MULMOD
		return 8 + eval_gexpr_count(G, tx, a["lhs"]) + eval_gexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Gpow":
		val = eval_gexpr(G, tx, a["rhs"])
		if val == 0:
			return 10
		else:
			return 5 + 10 + 10 * (1 + math.trunc(math.log(val))) + eval_gexpr_count(G, tx, a["lhs"]) + eval_gexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Ghash1":
		return 30 + 6 * 8 + eval_gexpr_count(G, tx, a["lhs"])
	elif a['op'] == "Ghash2":
		return 30 + 6 * 8 * 2 + eval_gexpr_count(G, tx, a["lhs"]) + eval_gexpr_count(G, tx, a["rhs"])
	elif a['op'] == "Ginp":
		if a["lhs"] >= len(tx["in"]):
			return 0
		if tx["in"][a["lhs"]] < len(G):
			return eval_gexpr_count(G, G[tx["in"][a["lhs"]]], a["rhs"])
		else:
			return 0
	elif a['op'] == "Goup":
		if a["lhs"] >= len(tx["out"]):
			return 0
		if tx["out"][a["lhs"]] < len(G):
			return eval_gexpr_count(G, G[tx["out"][a["lhs"]]], a["rhs"])
		else:
			return 0
	elif a['op'] == "Gomega":
		return 2
	elif a['op'] == "Gsymbol" and a["lhs"]["op"] == "GsymPk":
		return 0
	elif a['op'] == "Gsymbol" and a["lhs"]["op"] == "Gsigma":
		return 3
	elif a['op'] == "Gsymbol" and a["lhs"]["op"] == "Gsymy":
		return 3

def Knot(a):
	if a == "T":
		return "F"
	elif a == "F":
		return "T"
	elif a == "U":
		return "U"

def Kand(a, b):
	match (a, b):
		case ("F", "F"):
			return "F"
		case ("F", "U"):
			return "F" 
		case ("F", "T"):
			return "F"
		case ("U", "F"):
			return "F"
		case ("U", "U"):
			return "U" 
		case ("U", "T"):
			return "U"
		case ("T", "F"):
			return "F"
		case ("T", "U"):
			return "U" 
		case ("T", "T"):
			return "T"

def Kor(a, b):
	match (a, b):
		case ("F", "F"):
			return "F"
		case ("F", "U"):
			return "U" 
		case ("F", "T"):
			return "T"
		case ("U", "F"):
			return "U"
		case ("U", "U"):
			return "U" 
		case ("U", "T"):
			return "T"
		case ("T", "F"):
			return "T"
		case ("T", "U"):
			return "T" 
		case ("T", "T"):
			return "T"

def Kto(a, b):
	return Kor(Knot(a), b)

def eval_bexpr(G, tx, b):   # to "T"/"F"/"U"
	if b["op"] == "Bneg":
		return Knot(eval_bexpr(G, tx, b["lhs"]))
	elif b["op"] == "Bbot":
		return "F"
	elif b["op"] == "Btop":
		return "T"
	elif b["op"] == "BU":
		return "U"
	elif b["op"] == "Band":
		return Kand(eval_bexpr(G, tx, b["lhs"]), eval_bexpr(G, tx, b["rhs"]))
	elif b["op"] == "Bor":
		return Kor(eval_bexpr(G, tx, b["lhs"]), eval_bexpr(G, tx, b["rhs"]))
	elif b["op"] == "Bto":
		lhsRes = eval_bexpr(G, tx, b["lhs"])
		if lhsRes == "F":
			return "T"
		else:
			return Kor(Knot(lhsRes), eval_bexpr(G, tx, b["rhs"]))
	elif b["op"] == "BeqA":
		p = eval_aexpr(G, tx, b["lhs"])
		q = eval_aexpr(G, tx, b["rhs"])
		if p == -1 or q == -1:
			return "U"
		elif p == q:
			return "T"
		else:
			return "F"
	elif b["op"] == "BlessA":
		p = eval_aexpr(G, tx, b["lhs"])
		q = eval_aexpr(G, tx, b["rhs"])
		if p == -1 or q == -1:
			return "U"
		elif p < q:
			return "T"
		else:
			return "F"
	elif b["op"] == "BleeqA":
		p = eval_aexpr(G, tx, b["lhs"])
		q = eval_aexpr(G, tx, b["rhs"])
		if p == -1 or q == -1:
			return "U"
		elif p <= q:
			return "T"
		else:
			return "F"
	elif b["op"] == "BVerG":
		return "T"
	elif b["op"] == "BeqG":
		p = eval_gexpr(G, tx, b["lhs"])
		q = eval_gexpr(G, tx, b["rhs"])
		if p == -1 or q == -1:
			return "U"
		elif p == q:
			return "T"
		else:
			return "F"
	elif b["op"] == "BlessG":
		p = eval_gexpr(G, tx, b["lhs"])
		q = eval_gexpr(G, tx, b["rhs"])
		if p == -1 or q == -1:
			return "U"
		elif p < q:
			return "T"
		else:
			return "F"
	elif b["op"] == "BleeqG":
		p = eval_gexpr(G, tx, b["lhs"])
		q = eval_gexpr(G, tx, b["rhs"])
		if p == -1 or q == -1:
			return "U"
		elif p <= q:
			return "T"
		else:
			return "F"
	elif b["op"] == "Binp":
		if b["lhs"] >= len(tx["in"]):
			return "U"
		if tx["in"][b["lhs"]] < len(G):
			return eval_bexpr(G, G[tx["in"][b["lhs"]]], b["rhs"])
		else:
			return "U"
	elif b["op"] == "Boup":
		if b["lhs"] >= len(tx["out"]):
			return "U"
		if tx["out"][b["lhs"]] < len(G):
			return eval_bexpr(G, G[tx["out"][b["lhs"]]], b["rhs"])
		else:
			return "U"
	elif b["op"] == "BRI":
		if b["lhs"] < len(tx["out"]) and tx["out"][b["lhs"]] < len(G):
			txo = G[tx["out"][b["lhs"]]]
			evalLam = []
			for i in range(len(b["rhs"])):
				evalLam.append(eval_aexpr(G, tx, b["rhs"][i]))
			if txo["RI"] == tx["RI"] and txo["lambda"] == evalLam:
				return "T"
			else:
				return "F"
		else:
			return "U"
	elif b["op"] == "BinRI":
		if b["lhs"] < len(tx["in"]) and tx["in"][b["lhs"]] < len(G):
			txi = G[tx["in"][b["lhs"]]]
			evalLam = []
			for i in range(len(b["rhs"])):
				evalLam.append(eval_aexpr(G, tx, b["rhs"][i]))
			if txi["RI"] == tx["RI"] and txi["lambda"] == evalLam:
				return "T"
			else:
				return "F"
		else:
			return "U"

def count_op_keys(obj):
    if isinstance(obj, dict):
        # Count "op" in this dict + recurse into values
        return (1 if "op" in obj else 0) + sum(count_op_keys(v) for v in obj.values())
    elif isinstance(obj, list):
        # Recurse into each element
        return sum(count_op_keys(i) for i in obj)
    else:
        return 0

def eval_bexpr_count(G, tx, b):   # to Int
	if b["op"] == "Bneg":
		return 3 + eval_bexpr_count(G, tx, b["lhs"])
	elif b["op"] == "Bbot":
		return 0
	elif b["op"] == "Btop":
		return 0
	elif b["op"] == "BU":
		return 0
	elif b["op"] == "Band":
		# By representing T/U/F by 1/0/-1, 
		# and/or is converted to min/max or a comparison, costing 3 gas
		return 3 + eval_bexpr_count(G, tx, b["lhs"]) + eval_bexpr_count(G, tx, b["rhs"])
	elif b["op"] == "Bor":
		return 3 + eval_bexpr_count(G, tx, b["lhs"]) + eval_bexpr_count(G, tx, b["rhs"])
	elif b["op"] == "Bto":
		if eval_bexpr(G, tx, b["lhs"]) == "F":
			return 6 + eval_bexpr_count(G, tx, b["lhs"])
		else:
			return 6 + eval_bexpr_count(G, tx, b["lhs"]) + eval_bexpr_count(G, tx, b["rhs"])
	elif b["op"] == "BeqA":
		return 3 + eval_aexpr_count(G, tx, b["lhs"]) + eval_aexpr_count(G, tx, b["rhs"])
	elif b["op"] == "BlessA":
		return 3 + eval_aexpr_count(G, tx, b["lhs"]) + eval_aexpr_count(G, tx, b["rhs"])
	elif b["op"] == "BleeqA":
		return 6 + eval_aexpr_count(G, tx, b["lhs"]) + eval_aexpr_count(G, tx, b["rhs"])
	elif b["op"] == "BVerG":
		# takes 3,000 gas (since EIP-1108, ecrecover)
		return 3000
	elif b["op"] == "BeqG":
		return 3 + eval_gexpr_count(G, tx, b["lhs"]) + eval_gexpr_count(G, tx, b["rhs"])
	elif b["op"] == "BlessG":
		return 3 + eval_gexpr_count(G, tx, b["lhs"]) + eval_gexpr_count(G, tx, b["rhs"])
	elif b["op"] == "BleeqG":
		return 6 + eval_gexpr_count(G, tx, b["lhs"]) + eval_gexpr_count(G, tx, b["rhs"])
	elif b["op"] == "Binp":
		if b["lhs"] >= len(tx["in"]):
			return 0
		if tx["in"][b["lhs"]] < len(G):
			return eval_bexpr_count(G, G[tx["in"][b["lhs"]]], b["rhs"])
		else:
			return 0
	elif b["op"] == "Boup":
		if b["lhs"] >= len(tx["out"]):
			return 0
		if tx["out"][b["lhs"]] < len(G):
			return eval_bexpr_count(G, G[tx["out"][b["lhs"]]], b["rhs"])
		else:
			return 0
	elif b["op"] == "BRI":
		# To compare two RIs, just take their hash (gas: 30 + 6 * (size of input in words))
		#    and compare two int256's (gas: 3)
		if b["lhs"] < len(tx["out"]) and tx["out"][b["lhs"]] < len(G):
			txo = G[tx["out"][b["lhs"]]]
			return 3 + (30 + 6 * count_op_keys(txo["RI"])) + (30 + 6 * count_op_keys(tx["RI"]))
		else:
			return 0
	elif b["op"] == "BinRI":
		if tx["in"][b["lhs"]] < len(G):
			txi = G[tx["in"][b["lhs"]]]
			return 3 + (30 + 6 * count_op_keys(txi["RI"])) + (30 + 6 * count_op_keys(tx["RI"]))
		else:
			return 0

def process_tx(G, tx, accumulateCount):
	G = G + [tx]
	# tx's shall be added in order
	res = eval_bexpr(G, tx, tx["RI"])
	resCount = eval_bexpr_count(G, tx, tx["RI"])
	if res:
		inpList = tx["in"]
		for i in inpList:
			assert i < len(G)
			prevRes = eval_bexpr(G, G[i], G[i]["RI"])
			resCount += eval_bexpr_count(G, G[i], G[i]["RI"])
			if not prevRes:
				res = False
				break
	return (G, res, resCount + accumulateCount)

def tx_load(addr):
	with open(addr) as f:
		tx = json.load(f)
	with open(tx["RIurl"]) as f:
		tx["RI"] = json.load(f)
	return tx
