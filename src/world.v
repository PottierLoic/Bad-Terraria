module main
import rand

struct World {
	mut:
		player Player
		chunk_grid [][]Chunk
}

fn (mut w World) generate_terrain ()  {
	println("generating terrain...")

	height := world_height*chunk_size
	width := world_width*chunk_size

	mut heights := []int{}
	heights << height / 2 + rand.int_in_range(-5, 5) or { 0 }
	for i in 0..width - 1 {
		heights << heights.last() + rand.int_in_range(-1, 1) or { 0 }
	}

	for row in 0..world_height{
		for col in 0..world_width {
			for y in 0..chunk_size{
				for x in 0..chunk_size {
					if w.chunk_grid[row][col].y + y < heights[w.chunk_grid[row][col].x + x] {
						print("a")
					}
				}
			}
		}
	}

	println("terrain generated")
}

fn (mut w World) update() {
	print("")
}

fn init_world() World {
	mut w := World{
		player: init_player("loic", 150, 150)
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