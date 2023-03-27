module main

pub struct Game {
	world World
}

fn (g Game) print () {
	g.world.print()
}

pub fn init_game() Game {
	return Game{
		world: init_world()
	}
}