extends Node

const PIZZA = preload("res://scenes/pizza.tscn")

var num_pizzas_left = 3
var pizza_board: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_pizza()
	pizza_board = get_node("PizzaBoard")
	pizza_board.is_occupied.connect(_move_board)

func _create_pizza():
	var pizza = PIZZA.instantiate()
	add_child(pizza)

func _move_board():

	pizza_board.get_node("AnimationPlayer").play("Move_in_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
