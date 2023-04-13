module main

import rand

struct Chunk {
	mut:
		cells [][]Cell
		x int
		y int
}

fn (mut c Chunk) set_cell (x int, y int, mat string) {
	c.cells[y][x] = init_cell(mat)
}

fn init_chunk(x int, y int) Chunk {
	mut chunk := Chunk{
		x: x
		y: y
	}
	mat := rand.element(["dirt", "grass"]) or { "dirt" }
	for idy in 0..chunk_size {
		chunk.cells << []Cell{}
		for _ in 0..chunk_size {
			chunk.cells[idy] << init_cell(mat)
		}
	}
	return chunk
}