module main

pub struct Game {
	mut :
		world World
}

fn (mut g Game) update () {
	g.world.update()
}

fn (g Game) print () {
	g.world.print()
}

pub fn init_game() Game {
	return Game{
		world: init_world()
	}
}