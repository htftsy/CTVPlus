import json

rhsCase0 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": { # BRI0 [1]
			"op": "BRI",
			"lhs": 0,
			"rhs": [
				{
					"op": "Anum",
					"lhs": 1
				}
			]
		},
		"rhs": { # BRI1 [1]
			"op": "BRI",
			"lhs": 1,
			"rhs": [
				{
					"op": "Anum",
					"lhs": 1
				}
			]
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": { # Ver(y_0, sig_0)
			"op": "BVerG",
			"lhs": {
				"op": "Gsymbol",
				"lhs": {
					"op": "Gsymy",
					"n": 0
				}
			},
			"rhs": {
				"op": "Gsymbol",
				"lhs": {
					"op": "Gsigma",
					"n": 0
				}
			}
		},
		"rhs": { # oup_2 bot
			"op": "Boup",
			"lhs": 2,
			"rhs": {
				"op": "Bbot"
			}
		}
	}
}

rhsCase1 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": { # BRI0 [2]
			"op": "BRI",
			"lhs": 0,
			"rhs": [
				{
					"op": "Anum",
					"lhs": 2
				}
			]
		},
		"rhs": { # Ver(y_0, sig_0)
			"op": "BVerG",
			"lhs": {
				"op": "Gsymbol",
				"lhs": {
					"op": "Gsymy",
					"n": 0
				}
			},
			"rhs": {
				"op": "Gsymbol",
				"lhs": {
					"op": "Gsigma",
					"n": 0
				}
			}
		}
	},
	"rhs": { # oup_1 bot
		"op": "Boup",
		"lhs": 1,
		"rhs": {
			"op": "Bbot"
		}
	}
}

CorrWin = {
	"op": "Band",
	"lhs": {
		"op": "Bto",
		"lhs": {
			"op": "BlessA",
			"lhs": { # |Rnd - inp_0 x_0|
				"op": "Aabs",
				"lhs": {
					"op": "Asub",
					"lhs": {
						"op": "ARnd"
					},
					"rhs": {
						"op": "Ainp",
						"lhs": 0,
						"rhs": {
							"op": "Asymbol",
							"lhs": {
								"op": "Asymx",
								"n": 0
							}
						}
					}
				}
			},
			"rhs": { # |Rnd - inp_1 x_0|
				"op": "Aabs",
				"lhs": {
					"op": "Asub",
					"lhs": {
						"op": "ARnd"
					},
					"rhs": {
						"op": "Ainp",
						"lhs": 1,
						"rhs": {
							"op": "Asymbol",
							"lhs": {
								"op": "Asymx",
								"n": 0
							}
						}
					}
				}
			}
		},
		"rhs": { # oup_0 y_0 = inp_0 y_0
			"op": "BeqG",
			"lhs": {
				"op": "Goup",
				"lhs": 0,
				"rhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 0
					}
				}
			},
			"rhs": {
				"op": "Ginp",
				"lhs": 0,
				"rhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 0
					}
				}
			}
		}
	},
	"rhs": {
		"op": "Bto",
		"lhs": {
			"op": "BleeqA",
			"lhs": { # |Rnd - inp_1 x_0|
				"op": "Aabs",
				"lhs": {
					"op": "Asub",
					"lhs": {
						"op": "ARnd"
					},
					"rhs": {
						"op": "Ainp",
						"lhs": 1,
						"rhs": {
							"op": "Asymbol",
							"lhs": {
								"op": "Asymx",
								"n": 0
							}
						}
					}
				}
			},
			"rhs": { # |Rnd - inp_0 x_0|
				"op": "Aabs",
				"lhs": {
					"op": "Asub",
					"lhs": {
						"op": "ARnd"
					},
					"rhs": {
						"op": "Ainp",
						"lhs": 0,
						"rhs": {
							"op": "Asymbol",
							"lhs": {
								"op": "Asymx",
								"n": 0
							}
						}
					}
				}
			}
		},
		"rhs": { # oup_0 y_0 = inp_1 y_0
			"op": "BeqG",
			"lhs": {
				"op": "Goup",
				"lhs": 0,
				"rhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 0
					}
				}
			},
			"rhs": {
				"op": "Ginp",
				"lhs": 1,
				"rhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 0
					}
				}
			}
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
				"op": "BVerG",
				"lhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 0
					}
				},
				"rhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsigma",
						"n": 0
					}
				}
			},
			"rhs": { # inpRI 0 [1]
				"op": "BinRI",
				"lhs": 0,
				"rhs": [
					{
						"op": "Anum",
						"lhs": 1
					}
				]
			}
		},
		"rhs": {
			"op": "Band",
			"lhs": { # inpRI 1 [1]
				"op": "BinRI",
				"lhs": 1,
				"rhs": [
					{
						"op": "Anum",
						"lhs": 1
					}
				]
			},
			"rhs": { # inp_2 bot
				"op": "Binp",
				"lhs": 2,
				"rhs": {
					"op": "Bbot"
				}
			}
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": { 
			"op": "Band",
			"lhs": CorrWin,
			"rhs": { # oup_1 bot
				"op": "Boup",
				"lhs": 1,
				"rhs": {
					"op": "Bbot"
				}
			}
		},
		"rhs": { # oup_0 out_1 = 0
			"op": "BeqA",
			"lhs": {
				"op": "Aoup",
				"lhs": 0,
				"rhs": {
					"op": "Asymbol",
					"lhs": {
						"op": "Asymom",
						"n": 1
					}
				}
			},
			"rhs": {
				"op": "Anum",
				"lhs": 0
			}
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
				},
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
				},
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
			},
			"rhs": {
				"op": "Anum",
				"lhs": 2
			}
		},
		"rhs": rhsCase2
	}
}

with open("RI.json", "w") as f:
	json.dump(final, f, indent = 4)

