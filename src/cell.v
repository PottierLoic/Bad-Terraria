module main

struct Cell {
	mut:
		x int
		y int
		cell_type string
}

fn init_cell (x int, y int, cell_type string) Cell {
	return Cell{x: x, y: y, cell_type: cell_type}
}