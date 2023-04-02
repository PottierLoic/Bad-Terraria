module main

pub struct Game {
	mut :
		world World
}

fn (mut g Game) update () {
	g.world.update()
}

pub fn init_game() Game {
	return Game{
		world: init_world()
	}
}