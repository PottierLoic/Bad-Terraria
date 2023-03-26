module main

struct Player {
	mut:
		name string
		x f32
		y f32
		health int
}

fn (mut p Player) move(x f32, y f32) {
	p.x += x
	p.y += y
}

fn (p Player) print_player () {
	println('Player $p.name is at ($p.x, $p.y) with $p.health health')
}

fn init_player(name string, x f32, y f32) Player {
	return Player {
		name: name
		x: 0.0
		y: 0.0
		health: 100
	}
}