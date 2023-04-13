module main

struct Player {
	mut:
		name string
		x f32
		y f32
		max_health int = 100
		health int
}

fn (mut p Player) move(x f32, y f32) {
	p.x += x
	p.y += y
}

fn (mut p Player) take_damage(damage int) {
	p.health -= damage
	if p.health < 0 {
		p.health = 0
	}
}

fn (mut p Player) heal(heal int) {
	p.health += heal
	if p.health > p.max_health {
		p.health = p.max_health
	}
}

fn (p Player) print () {
	println('Player $p.name is at ($p.x, $p.y) with $p.health health')
}

fn init_player(name string, x f32, y f32) Player {
	return Player {
		name: name
		x: x
		y: y
		health: 100
	}
}