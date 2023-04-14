module main

struct Item {
mut:
	name  string
	price int
}

fn init_item(name string, price int) Item {
	return Item{
		name: name
		price: price
	}
}
