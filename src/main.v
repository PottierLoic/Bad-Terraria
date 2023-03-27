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
	for cell in app.game.world.cells {
		for xx in 0..cell_size {
			for yy in 0..cell_size {
				if cell.x + xx < 0 || cell.x + xx >= screen_width || cell.y +yy < 0 || cell.y + yy >= screen_height {
					continue
				}
				unsafe { 
					if cell.cell_type == 'dirt' {
						app.pixels[(cell.x + xx) + (cell.y + yy) * screen_width] = u32(dirt_color.abgr8()) 
					} else if cell.cell_type == 'grass' {
						app.pixels[(cell.x + xx) + (cell.y + yy) * screen_width] = u32(grass_color.abgr8()) 
					}
					
				}
			}
		}
	}

	// display player
	

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
		create_window: true
		window_title: 'Bad-Terraria'
	)

	app.gg.run()
}