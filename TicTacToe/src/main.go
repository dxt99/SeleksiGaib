package main

import (
	"fmt"
	"time"
)

func main() {
	initGame()
	p := time.Now().Unix()
	p = p % 2
	// TODO: randomize first player, 1 is always AI
	for winner() == -1 && !full() {
		if p == 1 {
			// ai's turn
			botPlay()
			p = 0
			continue
		}
		printGame()
		fmt.Printf("Enter move: ")
		var move int
		fmt.Scanf("%d\n", &move)
		i := (move - 1) / 3
		j := (move - 1) % 3
		if i >= 0 && i < 3 && j >= 0 && j < 3 && game[i][j] == -1 {
			play(i, j, 0)
			p = 1
		} else {
			fmt.Printf("Invalid move \n\n")
		}
	}
	printGame()
	if winner() == 1 {
		fmt.Println("AI Wins")
	} else if winner() == 0 {
		fmt.Println("Player wins")
	} else {
		fmt.Println("Game draw")
	}
}
