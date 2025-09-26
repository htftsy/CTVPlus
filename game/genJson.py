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
	"op": "Band",
	"lhs": {
		"op": "Bto",
		"lhs": {
			"op": "BlessG",
			"lhs": { # |Rnd - inp_0 y_1|
			},
			"rhs": { # |Rnd - inp_1 y_1|
			}
		},
		"rhs": { # oup_0 y_0 = inp_0 y_0
		}
	},
	"rhs": {
		"op": "Bto",
		"lhs": {
			"op": "BlessG",
			"lhs": { # |Rnd - inp_1 y_1|
			},
			"rhs": { # |Rnd - inp_0 y_1|
			}
		},
		"rhs": { # oup_0 y_0 = inp_1 y_0
		}
	}
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
		"lhs": { 
			"op": "Band",
			"lhs": CorrWin,
			"rhs": { # oup_1 bot
			}
		},
		"rhs": { # oup_0 out_1 = 0
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

