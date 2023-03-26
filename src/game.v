module main

pub struct Game {
	world World
}

pub fn init_game() Game {
	return Game{
		world: init_world()
	}
}