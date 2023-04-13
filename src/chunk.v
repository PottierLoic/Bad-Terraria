module main

import rand

struct Chunk {
	mut:
		cells [][]Cell
		x int
		y int
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