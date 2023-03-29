module main
import rand

struct World {
	mut:
		player Player
		grid [][]Cell
}

fn (mut w World) generate_terrain ()  {

	for _ in 0..screen_height/cell_size {
		w.grid << []Cell{}
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
}

fn (w World) print() {
	for row in w.grid {
		for cell in row {
			if cell != unsafe { nil } {
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