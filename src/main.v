module main
import gg

struct App {
	mut:
		gg &gg.Context = unsafe { nil }
		iidx int
		pixels &u32 = unsafe { vcalloc(screen_width * screen_height * sizeof(u32)) }
		game Game = init_game()
}

fn (mut app App) display() {
	// display chunks
	chunks := app.game.world.chunk_grid
	player := app.game.world.player

	for chunk_row in chunks {
		for chunk in chunk_row {
			if chunk.x + chunk_size < player.x - screen_width/2 || chunk.x > player.x + screen_width/2 || chunk.y + chunk_size < player.y - screen_height/2 || chunk.y > player.y + screen_height/2 {
				print("chunk out of bounds\n")
				continue
			}
			for row in 0..chunk_size {
				for col in 0..chunk_size {
					if chunk.cells[row][col].cell_type == "empty" {
						continue
					}
					for xx in 0..cell_size {
						for yy in 0..cell_size {
							if chunk.x + col*cell_size + xx >= player.x - screen_width/2 || chunk.x + col*cell_size + xx < player.x + screen_width/2 || chunk.y + row*cell_size + yy >= player.y - screen_height/2 || chunk.y + row*cell_size + yy < player.y + screen_height/2 {
								continue
							}
							print("x: $chunk.x + $col*cell_size + $xx, y: $chunk.y + $row*cell_size + $yy\n")
							app.pixels[col*cell_size + xx - (player.x - screen_width/2) + (row*cell_size + yy - (player.y - screen_height/2) * screen_width)] = u32(dirt_color.abgr8())
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
	app.game.update()
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