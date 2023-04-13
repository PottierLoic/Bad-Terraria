module main
import rand

struct World {
	mut:
		player Player
		chunk_grid [][]Chunk
}

fn (mut w World) generate_terrain ()  {

	height := world_height*chunk_size
	width := world_width*chunk_size

	mut heights := []int{}
	heights << height / 2 + rand.int_in_range(-5, 6) or { 0 }
	for _ in 0..width {
		mut h := heights.last() + rand.int_in_range(-1, 2) or { 0 }
		if h < 0 { h = 0 } else if h > height { h = height }
		heights << h
	}

	for row in 0..world_height{
		for col in 0..world_width {
			for y in 0..chunk_size{
				for x in 0..chunk_size {
					if row * chunk_size + y < heights[col * chunk_size + x] {
						w.chunk_grid[row][col].set_cell(x, y, "empty")
					} else if row * chunk_size + y == heights[col * chunk_size + x] {
						w.chunk_grid[row][col].set_cell(x, y, "grass")
					} else {
						w.chunk_grid[row][col].set_cell(x, y, "dirt")
					}
				}
			}
		}
	}
}

fn (mut w World) update() {
	print("")
}

fn init_world() World {
	mut w := World{
		player: init_player("loic", 2000, 500)
	}

	for y in 0..world_height {
		w.chunk_grid << []Chunk{}
		for x in 0..world_width {
			w.chunk_grid[y] << init_chunk(x * chunk_full_size, y * chunk_full_size)
		}
	}
	w.generate_terrain()
	return w
}