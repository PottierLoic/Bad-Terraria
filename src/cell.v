module main

struct Cell {
	mut:
		cell_type string
}

fn init_cell (cell_type string) Cell {
	return Cell{cell_type: cell_type}
}