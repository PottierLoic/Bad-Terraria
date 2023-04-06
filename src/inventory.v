module main

struct Inventory {
	mut:
		items []Item

}

fn (mut inv Inventory) add(item Item) {
	inv.items << item
}

fn init_inventory() Inventory {
	return Inventory{
		items: []
	}
}