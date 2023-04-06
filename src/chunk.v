module main

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
	for idy in 0..chunk_size {
		chunk.cells << []Cell{}
		for _ in 0..chunk_size {
			chunk.cells[idy] << init_cell("dirt")
		}
	}
	return chunk
}