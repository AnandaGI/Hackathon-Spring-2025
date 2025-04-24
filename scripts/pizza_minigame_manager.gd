extends Node

const PIZZA = preload("res://scenes/pizza.tscn")
@onready var pizza_minigame_manager: Node = %PizzaMinigameManager
@onready var ready_label: Label = $ReadyLabel
@onready var display_label: Label = $DisplayLabel
@onready var pizza_board: Area2D = %PizzaBoard

var total_pizzas_made = 0
var ready_text_list = ["Ready?", "Set...", "GO!!!", ""]
var ready_test_index = 0
var time_left = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pizza_board.is_occupied.connect(_move_board)
	pizza_board.reset.connect(_on_reset)

func _create_pizza():
	var pizza = PIZZA.instantiate()
	add_child(pizza)
	total_pizzas_made += 1

func _ready_label_timeout() -> void:
	ready_label.text = ready_text_list[ready_test_index]
	ready_test_index += 1
	if ready_test_index < 4:
		ready_label.get_node("Timer").start()
	else:
		_create_pizza()
		display_label.text = str(time_left)
		display_label.get_node("Timer").start()

func _countdown():
	time_left -= 1
	display_label.text = str(time_left)
	if time_left > 0:
		display_label.get_node("Timer").start()
	else:
		display_label.add_theme_font_size_override("font_size", 8)
		if total_pizzas_made > 5:
			display_label.text = (
				"You made %s pizzas! You're on fire!" % str(total_pizzas_made)
			)
		else:
			display_label.text = (
				"You made %s pizzas... not so good :(" % str(total_pizzas_made)
			)

func _move_board():
	pizza_board.get_node("AnimationPlayer").play("Move_in_out")

func _on_reset():
	_create_pizza()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
