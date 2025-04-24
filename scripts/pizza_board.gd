extends Area2D

@onready var board_collision: CollisionShape2D = $CollisionShape2D

signal is_occupied
signal reset

var starting_position = position
var current_position = Vector2.ZERO
var pizza_node: Node2D = null

func _on_area_entered(area: Area2D) -> void:
	print("DEBUG: Pizza entered board collision")
	pizza_node = area.get_parent()
	
	#pizza_node.global_position = board_collision.global_position
	area.get_node("CollisionShape2D").queue_free()
	
	is_occupied.emit()

func _on_end_of_travel():
	print("DEBUG: Board has reached the end of its travel")
	pizza_node.queue_free()
	pizza_node = null

func _on_reset():
	emit_signal("reset")

func _process(delta: float) -> void:
	if pizza_node:
		pizza_node.global_position = board_collision.global_position
	#if pizza_node:
		#print("DEBUG: Difference = ", current_position.x)
		#position.x += 500 * delta
		#current_position.x = position.x
		#if current_position.x > 300:
			#pizza_node.queue_free()
			#pizza_node = null
			#
	#elif current_position.x > 0:
		#print("DEBUG: Difference = ", current_position.x)
		#position.x -= 500 * delta
	#
	##else:
		##print("DEBUG: Difference = ", current_position.x)
	#
	#if current_position.x < 0:
		#position = starting_position
