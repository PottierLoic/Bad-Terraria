module main
import gg

struct App {
	mut:
		gg &gg.Context = unsafe { nil }
		iidx int
		pixels &u32 = unsafe { vcalloc(screen_width * screen_height * sizeof(u32)) }
		game Game = init_game()
}

// will need a rework when cells are placed on a 2d grid instead of a 1d array
fn (mut app App) display() {
	// display cells
	for row in 0..app.game.world.grid.len {
		for col in 0..app.game.world.grid[row].len {
			for xx in 0..cell_size {
				for yy in 0..cell_size {
					if col*cell_size + xx < 0 || col*cell_size + xx >= screen_width || row*cell_size + yy < 0 || row*cell_size + yy >= screen_height {
						continue
					}
					unsafe { 
						if app.game.world.grid[row][col].cell_type == "dirt" {
							app.pixels[(col*cell_size + xx) + (row*cell_size + yy) * screen_width] = u32(dirt_color.abgr8()) 
						} else if app.game.world.grid[row][col].cell_type == "grass" {
							app.pixels[(col*cell_size + xx) + (row*cell_size + yy) * screen_width] = u32(grass_color.abgr8()) 
						} else if app.game.world.grid[row][col].cell_type == "air" {
							app.pixels[(col*cell_size + xx) + (row*cell_size + yy) * screen_width] = u32(grass_color.abgr8()) 
						}
					}
				}
			}
		}
	}

	// display player
	p := app.game.world.player
	for xx in int(-player_width/2)..int(player_width/2) {
		for yy in 0..player_height {	
			if p.x + xx < 0 || p.x + xx >= screen_width || p.y +yy < 0 || p.y + yy >= screen_height {
				continue
			}
			unsafe { 
				app.pixels[int(p.x + xx) + int(p.y + yy) * screen_width] = u32(player_color.abgr8()) 
			}
		}
	}

	mut istream_image := app.gg.get_cached_image_by_idx(app.iidx)
	istream_image.update_pixel_data(app.pixels)
	size := gg.window_size()
	app.gg.draw_image(0, 0, size.width, size.height, istream_image)
}

fn graphics_init(mut app App) {
	app.iidx = app.gg.new_streaming_image(screen_width, screen_height, 4, pixel_format: .rgba8)
}

fn frame(mut app App) {
	app.gg.begin()
	app.display()
	app.gg.end()
}

fn keydown(code gg.KeyCode, mod gg.Modifier, mut app App) {
	if code == gg.KeyCode.escape {
		app.gg.quit()
	}
	if code == gg.KeyCode.enter {
		app.game = init_game()
	}
}


fn main() {
	mut app := App {
		gg: 0
	}
	app.gg = gg.new_context(
		bg_color: bg_color
		frame_fn: frame
		init_fn: graphics_init
		user_data: &app
		width: screen_width
		height: screen_height
		keydown_fn: keydown
		create_window: true
		window_title: 'Bad-Terraria'
	)

	app.gg.run()
}