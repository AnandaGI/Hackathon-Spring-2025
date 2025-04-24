extends Area2D

var game_to_load = "pizza_minigame"
var body_occupied = false
signal activated

func _set_game(game):
	game_to_load = game

func _on_body_entered(body: Node2D) -> void:
	body_occupied = true

func _on_body_exited(body: Node2D) -> void:
	body_occupied = false

func _process(delta: float) -> void:
	if body_occupied:
		if Input.is_action_just_pressed("m1_click") or Input.is_action_just_pressed("jump"):
			activated.emit(game_to_load)
			print("DEBUG: Cabinet acivated")
