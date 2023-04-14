module main

import gg
import gx
import rand

struct Cell {
mut:
	cell_type string
	color     gg.Color
}

fn init_cell(cell_type string) Cell {
	mut color := gg.Color{}
	if cell_type == 'dirt' {
		color = rand.element(dirt_colors) or { dirt_colors[0] }
	} else if cell_type == 'grass' {
		color = rand.element(grass_colors) or { grass_colors[0] }
	} else {
		color = gx.black
	}
	return Cell{
		cell_type: cell_type
		color: color
	}
}
