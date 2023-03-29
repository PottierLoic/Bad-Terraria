module main
import rand

struct World {
	mut:
		player Player
		grid [][]Cell
}

fn (mut w World) generate_terrain ()  {
	println("generating terrain...")
	for _ in 0..screen_height/cell_size {
		w.grid << []Cell{}
		for _ in 0..screen_width/cell_size {
			w.grid[w.grid.len-1] << init_cell("air")
		}
	}
	
	mut soil_height := rand.int_in_range(screen_height/cell_size/2 - 5, screen_height/cell_size/2 + 5) or { screen_height/cell_size/2 }
	for col in 0..screen_width/cell_size {
		for row in 0..soil_height {
			w.grid[row][col] = init_cell("air")
		}
		w.grid[soil_height][col] = init_cell("grass")
		for row in soil_height+1..screen_height/cell_size {
			w.grid[row][col] = init_cell("dirt")
		}
		soil_height += rand.int_in_range(-1, 2) or { 0 }
	}	
	println("terrain generated")
}

fn (mut w World) update() {
	x := int(w.player.x/cell_size)
	y := int(w.player.y/cell_size)
	if x >= 0 && x < screen_width/cell_size && y+2 >= 0 && y+2 < screen_height/cell_size {
		if w.grid[y+2][x].cell_type == "air" {
			w.player.move(0.0, 10.0)
		}
	}
}

fn (w World) print() {
	for row in w.grid {
		for cell in row {
			if cell.cell_type != "air" {
				print('X')
			} else {
				print(' ')
			}
			print(' ')
		}
		println('')
	}
	w.player.print()
}

fn init_world() World {
	mut w := World{
		player: init_player("loic", 0.0, 0.0)
	}
	w.generate_terrain()
	return w
}