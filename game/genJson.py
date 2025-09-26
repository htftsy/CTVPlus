import json

rhsCase0 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": { # BRI0 [1]
		},
		"rhs": { # BRI1 [1]
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": { # Ver(y_0, sig_0)
		},
		"rhs": { # oup_2 bot
		}
	}
}

rhsCase1 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": { # BRI0 [2]
		},
		"rhs": { # Ver(y_0, sig_0)
		}
	},
	"rhs": { # oup_1 bot
	}
}

CorrWin = {
}

rhsCase2 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": {
			"op": "Band",
			"lhs": { # Ver(y_0, sig_0)
			},
			"rhs": { # inpRI 0 [2]
			}
		},
		"rhs": {
			"op": "Band",
			"lhs": { # inpRI 1 [2]
			},
			"rhs": { # inp_2 bot
			}
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": { # oup_1 bot
			"op": "Band",
			"lhs": CorrWin,
			"rhs": { # oup_0 out_1 = 0
			}
		},
		"rhs": {
		}
	}
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

