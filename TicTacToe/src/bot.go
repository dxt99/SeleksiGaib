package main

const MAX_INT int = 1e6

// returns value of current (game) node
func minimax(isPlaying bool) int {
	// base cases
	if winner() == 0 {
		return -1
	} else if winner() == 1 {
		return 1
	} else if full() {
		return 0
	}

	var bestVal int
	if isPlaying {
		// maximizing
		bestVal = -10000000
		for i := 0; i < 3; i++ {
			for j := 0; j < 3; j++ {
				if game[i][j] == -1 {
					game[i][j] = 1
					val := minimax(false)
					game[i][j] = -1
					if val > bestVal {
						bestVal = val
					}
				}
			}
		}
	} else {
		// minimizing
		bestVal = 10000000
		for i := 0; i < 3; i++ {
			for j := 0; j < 3; j++ {
				if game[i][j] == -1 {
					game[i][j] = 0
					val := minimax(true)
					game[i][j] = -1
					if val < bestVal {
						bestVal = val
					}
				}
			}
		}
	}
	return bestVal
}

// 1's turn, 0 is always player
func botPlay() {
	bestMove := -1
	bestVal := -1
	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			if game[i][j] == -1 {
				game[i][j] = 1
				val := minimax(false)
				game[i][j] = -1
				if val > bestVal {
					bestVal = val
					bestMove = i*3 + j + 1
				}
			}
		}
	}
	i := (bestMove - 1) / 3
	j := (bestMove - 1) % 3
	play(i, j, 1)
}
