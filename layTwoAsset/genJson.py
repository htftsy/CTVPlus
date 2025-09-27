import json

condiCase0 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": {
			"op": "Band",
			"lhs": {
				"op": "Binp",
				"lhs": 1,
				"rhs": {
					"op": "Bbot"
				}
			},
			"rhs": {
				"op": "Boup",
				"lhs": 1,
				"rhs": {
					"op": "Bbot"
				}
			}
		},
		"rhs": {
			"op": "Band",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Aoup",
					"lhs": 0,
					"rhs": {
						"op": "Asymbol",
						"lhs": {
							"op": "Asymx",
							"n": 1
						}
					}
				},
				"rhs": {
					"op": "Asymbol",
						"lhs": {
							"op": "Asymx",
							"n": 1
						}
				}
			},
			"rhs": {
				"op": "BRI",
				"lhs": 0,
				"rhs": []
			}
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": {
			"op": "Bor",
			"lhs": {
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
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 1
					}
				}
			},
			"rhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Aoup",
					"lhs": 0,
					"rhs": {
						"op": "Asymbol",
						"lhs": {
							"op": "Asymx",
							"n": 0
						}
					}
				},
				"rhs": {
					"op": "Anum",
					"lhs": 2
				}
			}
		},
		"rhs": {
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
	}
}

condiCase1 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": condiCase114,
		"rhs": condiCase128,
	},
	"rhs": {
		"op": "Band",
		"lhs": {
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
				"op": "Gsymbol",
				"lhs": {
					"op": "Gsymy",
					"n": 0
				}
			}
		},
		"rhs": {
			"op": "BeqG",
			"lhs": {
				"op": "Goup",
				"lhs": 1,
				"rhs": {
					"op": "Gsymbol",
					"lhs": {
						"op": "Gsymy",
						"n": 0
					}
				}
			},
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
						"op": "Aymx",
						"n": 0
					}
				},
				"rhs": {
					"op": "Anum",
					"lhs": 0
				}
			},
			"rhs": condiCase0
		},
		"rhs": {
			"op": "Bto",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Asymbol",
					"lhs": {
						"op": "Aymx",
						"n": 0
					}
				},
				"rhs": {
					"op": "Anum",
					"lhs": 1
				}
			},
			"rhs": condiCase1
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": {
			"op": "Bto",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Asymbol",
					"lhs": {
						"op": "Aymx",
						"n": 0
					}
				},
				"rhs": {
					"op": "Anum",
					"lhs": 2
				}
			},
			"rhs": condiCase2
		},
		"rhs": {
			"op": "Bto",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Asymbol",
					"lhs": {
						"op": "Aymx",
						"n": 0
					}
				},
				"rhs": {
					"op": "Anum",
					"lhs": 3
				}
			},
			"rhs": condiCase3
		}
	}
}