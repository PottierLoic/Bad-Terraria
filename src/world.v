module main
import rand

struct World {
	mut:
		player Player
		grid [][]Cell
		cells []Cell
}

// will need a rework when cells are placed on a 2D grid instead of a 1D array
fn (mut w World) generate_terrain ()  {
	mut soil_height := rand.int_in_range(screen_height/cell_size/2 - 5, screen_height/cell_size/2 + 5) or { screen_height/cell_size/2 }
	for col in 0..screen_width/cell_size {
		w.cells << init_cell(col * cell_size, soil_height * cell_size, 'grass')
		for row in soil_height+1..screen_height/cell_size {
			w.cells << init_cell(col * cell_size, row * cell_size, 'dirt')
		}
		soil_height += rand.int_in_range(-1, 2) or { 0 }
	}	
}

// will need a rework when cells are placed on a 2D grid instead of a 1D array
fn (w World) print() {
	for cell in w.cells {
		cell.print()
	}
	w.player.print()
}

fn init_world() World {
	mut w := World{
		player: init_player('loic', 0.0, 0.0)
	}
	w.generate_terrain()
	return w
}