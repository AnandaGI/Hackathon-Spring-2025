extends Node

const PIZZA = preload("res://scenes/pizza.tscn")

var pizza_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pizza = PIZZA.instantiate()
	add_child(pizza)
	pizza_list.append(pizza)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var curr_pizza = pizza_list[0]

	
