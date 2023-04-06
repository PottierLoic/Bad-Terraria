module main
import rand

struct World {
	mut:
		player Player
		chunk_grid [][]Chunk
}

fn (mut w World) generate_terrain ()  {
	println("generating terrain...")
	
	println("terrain generated")
}

fn (mut w World) update() {
	print("")
}

fn init_world() World {
	mut w := World{
		player: init_player("loic", 0.0, 0.0)
	}

	for y in 0..world_height {
		w.chunk_grid << []Chunk{}
		for x in 0..world_width {
			w.chunk_grid[y] << init_chunk(x, y)
		}
	}
	return w
}