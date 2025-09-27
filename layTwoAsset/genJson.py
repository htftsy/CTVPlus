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

condiCase114 = {
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
			"lhs": 2,
			"rhs": {
				"op": "Bbot"
			}
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": { # oup_0 x1 + oup_1 x1 = x1
			"op": "BeqA",
			"lhs": {
				"op": "Aadd",
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
					"op": "Aoup",
					"lhs": 1,
					"rhs": {
						"op": "Asymbol",
						"lhs": {
							"op": "Asymx",
							"n": 1
						}
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
		"rhs": { # oup_0 x0 <> 2
			"op": "Bneg",
			"lhs": {
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
		}
	}
}

condiCase128 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": { # oup_1 x0 <> 2
			"op": "Bneg",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Aoup",
					"lhs": 1,
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
			"op": "BRI",
			"lhs": 0,
			"rhs": []
		}
	},
	"rhs": {
		"op": "Band",
		"lhs": {
			"op": "BRI",
			"lhs": 1,
			"rhs": []
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

condiCase214 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": {
			"op": "Binp",
			"lhs": 2,
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
		"lhs": { # inp_0 x1 + inp_1 x1 = x1
			"op": "BeqA",
			"lhs": {
				"op": "Aadd",
				"lhs": {
					"op": "Ainp",
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
					"op": "Ainp",
					"lhs": 1,
					"rhs": {
						"op": "Asymbol",
						"lhs": {
							"op": "Asymx",
							"n": 1
						}
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
		"rhs": { # inp_0 x0 <> 1
			"op": "Bneg",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Ainp",
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
					"lhs": 1
				}
			}
		}
	}
}

condiCase257 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": {  # inp_1 x0 <> 1
			"op": "Bneg",
			"lhs": {
				"op": "BeqA",
				"lhs": {
					"op": "Ainp",
					"lhs": 1,
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
					"lhs": 1
				}
			}
		},
		"rhs": {
			"op": "BRI",
			"lhs": 0
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

condiCase2 = {
	"op": "Band",
	"lhs": {
		"op": "Band",
		"lhs": condiCase214,
		"rhs": condiCase257,
	},
	"rhs": {
		"op": "Band",
		"lhs": {
			"op": "BeqG",
			"lhs": {
				"op": "Ginp",
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
				"op": "Ginp",
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

condiCase3 = {
	"op": "Band",
	"lhs": {
		"op": "BeqG",
		"lhs": {
			"op": "Gsymbol",
			"lhs": {
				"op": "Gsymy",
				"n": 1
			}
		},
		"rhs": {
			"op": "Gnum",
			"lhs": 1
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
						"op": "Asymx",
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
						"op": "Asymx",
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
						"op": "Asymx",
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
						"op": "Asymx",
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

with open("RI.json", "w") as f:
	json.dump(final, f, indent = 4)
