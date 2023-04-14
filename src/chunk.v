module main

struct Chunk {
mut:
	cells [][]Cell
	x     int
	y     int
}

fn (mut c Chunk) set_cell(x int, y int, mat string) {
	c.cells[y][x] = init_cell(mat)
}

fn init_chunk(x int, y int) Chunk {
	mut chunk := Chunk{
		x: x
		y: y
	}
	for idy in 0 .. chunk_size {
		chunk.cells << []Cell{}
		for _ in 0 .. chunk_size {
			chunk.cells[idy] << init_cell('empty')
		}
	}
	return chunk
}
