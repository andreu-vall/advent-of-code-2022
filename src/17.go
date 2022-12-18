package main

import "fmt"

//It's also painful to search concrete things in go
//It lacks basic functionality...

func add(point1 [2]int, point2 [2]int) [2]int {
	return [2]int{point1[0] + point2[0], point1[1] + point2[1]}
}
func check_collision(piece_pos [2]int, piece [][2]int, mapa [][7]int) bool {
	for _, sq_rel := range piece {
		var sq_pos = add(piece_pos, sq_rel)
		if sq_pos[0] < 0 || sq_pos[1] < 0 || sq_pos[1] >= 7 || mapa[sq_pos[0]][sq_pos[1]] == 1 {
			return true
		}
	}
	return false
}
func put_piece(piece_pos [2]int, piece [][2]int, mapa [][7]int) int {
	var height = -1
	for _, sq_rel := range piece {
		var sq_pos = add(piece_pos, sq_rel)
		mapa[sq_pos[0]][sq_pos[1]] = 1
		if sq_pos[0] > height {
			height = sq_pos[0]
		}
	}
	return height
}
func all_true(array [7]int) bool {
	for _, val := range array {
		if val == 0 {
			return false
		}
	}
	return true
}

func main() {
	var moves string
	fmt.Scanf("%s", &moves)
	var move_n = 0

	var pieces [5][][2]int
	pieces[0] = [][2]int{{0, 0}, {0, 1}, {0, 2}, {0, 3}}
	pieces[1] = [][2]int{{0, 1}, {1, 0}, {1, 1}, {1, 2}, {2, 1}}
	pieces[2] = [][2]int{{0, 0}, {0, 1}, {0, 2}, {1, 2}, {2, 2}}
	pieces[3] = [][2]int{{0, 0}, {1, 0}, {2, 0}, {3, 0}}
	pieces[4] = [][2]int{{0, 0}, {0, 1}, {1, 0}, {1, 1}}

	var mapa [][7]int //Wtf not using a variable crashes the program
	var mapa_height = -1
	for len(mapa)-mapa_height < 8 { //WTF for is go's while
		mapa = append(mapa, [7]int{0, 0, 0, 0, 0, 0, 0})
	}
	var total_peces = 1000000000000
	var first_repetit_peces = 2551 //LOL I harcoded it hehe
	var peces_per_cicle = 1725
	var cicles = (total_peces - first_repetit_peces) / peces_per_cicle
	var sobrant = (total_peces - first_repetit_peces) % peces_per_cicle

	var height_per_cicle = 2728

	//var pleno = 0
	//var pleno_timestamp [5][]int
	for piece_count := 0; piece_count < first_repetit_peces+sobrant; piece_count++ {
		var piece_n = piece_count % 5
		var piece_pos = [2]int{mapa_height + 4, 2}

		var move [2]int
		for true {
			if moves[move_n] == '>' {
				move = [2]int{0, 1}
			} else { //WTF I can't put the else in the next line WTF is this???
				move = [2]int{0, -1}
			}
			if !check_collision(add(piece_pos, move), pieces[piece_n], mapa) {
				piece_pos = add(piece_pos, move)
			}
			move_n++
			if move_n == len(moves) {
				move_n = 0
			}
			move = [2]int{-1, 0}
			if check_collision(add(piece_pos, move), pieces[piece_n], mapa) {
				var piece_height = put_piece(piece_pos, pieces[piece_n], mapa)
				if piece_height > mapa_height {
					mapa_height = piece_height
					for len(mapa)-mapa_height < 8 {
						mapa = append(mapa, [7]int{0, 0, 0, 0, 0, 0, 0})
					}
				} else { //If height increases, it won't be fully covered
					if all_true(mapa[mapa_height]) {
						//fmt.Print(piece_count, move_n, mapa_height+1, "\n")
						//pleno++
					}

				}
				break
			} else {
				piece_pos = add(piece_pos, move)
			}
		}
		if piece_count == 2021 {
			fmt.Print("Part1: ", mapa_height+1, "\n")
		}
	}
	fmt.Print("Part2: ", mapa_height+1+cicles*height_per_cicle, "\n")
}
