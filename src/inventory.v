module main

struct Inventory {
mut:
	items []Item
}

fn (mut inv Inventory) add(item Item) {
	if inv.items.len < inventory_size {
		inv.items << item
	}
}

fn (mut inv Inventory) delete(idx int) {
	if inv.items.len >= idx {
		inv.items.delete(idx)
	}
}

fn init_inventory() Inventory {
	return Inventory{
		items: []
	}
}
