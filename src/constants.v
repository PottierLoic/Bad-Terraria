module main
import gx

const (
	// Sizes
	screen_width = 800
	screen_height = 800
	cell_size = 10

	player_width = 20
	player_height = 40

	// Colors
	bg_color = gx.rgb(153, 255, 255)
	player_color = gx.rgb(255, 0, 0)
	dirt_colors = [gx.rgb(102, 51, 0), gx.rgb(102, 51, 15), gx.rgb(112, 45, 0)]
	grass_colors = [gx.rgb(153, 255, 153), gx.rgb(164, 255, 150), gx.rgb(153, 245, 160)]
	
	// Generation
	world_width = 10
	world_height = 10
	chunk_size = 10

	chunk_full_size = chunk_size * cell_size

	// Player stats


	// Enemy stats

)