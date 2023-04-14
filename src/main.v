module main

import gg

struct App {
mut:
	gg     &gg.Context = unsafe { nil }
	iidx   int
	pixels &u32 = unsafe { vcalloc(screen_width * screen_height * sizeof(u32)) }
	game   Game = init_game()
}

// need changes since chunk x, y are now in the same scale as player x, y, will simplify a lot display
fn (mut app App) display() {
	app.pixels = unsafe { vcalloc(screen_width * screen_height * sizeof(u32)) }
	player := app.game.world.player

	// display chunks
	chunks := app.game.world.chunk_grid
	for chunk_row in chunks {
		for chunk in chunk_row {
			if chunk.x + chunk_full_size < player.x - screen_width / 2 {
				continue
			}
			if chunk.x > player.x + screen_width / 2 {
				continue
			}
			if chunk.y + chunk_full_size < player.y - screen_height / 2 {
				continue
			}
			if chunk.y > player.y + screen_height / 2 {
				continue
			}
			for row in 0 .. chunk_size {
				for col in 0 .. chunk_size {
					if chunk.cells[row][col].cell_type == 'empty' {
						continue
					}
					for xx in 0 .. cell_size {
						for yy in 0 .. cell_size {
							relative_x := chunk.x + col * cell_size + xx - player.x + screen_width / 2
							relative_y := chunk.y + row * cell_size + yy - player.y + screen_height / 2
							if relative_x < 0 || relative_x > screen_width || relative_y < 0 || relative_y > screen_height {
								continue
							}
							unsafe { app.pixels[int(relative_x) + int(relative_y) * screen_width] = u32(chunk.cells[row][col].color.abgr8()) }
						}
					}
				}
			}
		}
	}

	// display player | must be moved before world display to handle screen border and chunk disparition
	for xx in 0 .. player_width {
		for yy in 0 .. player_height {
			relative_x := screen_width / 2 + xx
			relative_y := screen_height / 2 + yy
			unsafe { app.pixels[int(relative_x) + int(relative_y) * screen_width] = u32(player_color.abgr8()) }
		}
	}

	// display all stored pixels, everything that is drawed with pixels directly need to be done before and put in app.pixels.
	mut istream_image := app.gg.get_cached_image_by_idx(app.iidx)
	istream_image.update_pixel_data(app.pixels)
	size := gg.window_size()
	app.gg.draw_image(0, 0, size.width, size.height, istream_image)

	// displaying other images that is not stored in app.pixels need to be done here.
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
	} else if code == gg.KeyCode.enter {
		app.game = init_game()
	} else if code == gg.KeyCode.left {
		app.game.world.player.move(-5, 0)
	} else if code == gg.KeyCode.right {
		app.game.world.player.move(5, 0)
	} else if code == gg.KeyCode.down {
		app.game.world.player.move(0, 5)
	} else if code == gg.KeyCode.up {
		app.game.world.player.move(0, -5)
	}
}

fn main() {
	mut app := App{
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
