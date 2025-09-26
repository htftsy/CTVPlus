import json

rhsCase0 = {
	
}

final = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": {
			"op": "Bto",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Asymbol",
					"lhs": {
						"op": "Asymlam",
						"n": 0
					}
				}
				"rhs": {
					"op": "Anum",
					"lhs": 0
				}
			},
			"rhs": rhsCase0
		},
		"rhs": {
			"op": "Bto",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Asymbol",
					"lhs": {
						"op": "Asymlam",
						"n": 0
					}
				}
				"rhs": {
					"op": "Anum",
					"lhs": 1
				}
			},
			"rhs": rhsCase1
		}
	},
	"rhs": {
		"op": "Bto",
		"lhs": {
			"op": "BeqA",
			"lhs": {
				"op": "Asymbol",
				"lhs": {
					"op": "Asymlam",
					"n": 0
				}
			}
			"rhs": {
				"op": "Anum",
				"lhs": 2
			}
		},
		"rhs": rhsCase2
	}
}

