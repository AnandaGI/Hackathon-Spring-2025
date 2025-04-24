extends Node2D

@onready var cabinet_manager: Node2D = %CabinetManager

func _ready() -> void:
	cabinet_manager.cabinet_activated.connect(_on_cabinet_manager_cabinet_activated)

func _on_cabinet_manager_cabinet_activated(game_to_load) -> void:
	print("DEBUG: Attempted to change scene with game: ", "res://scenes/{0}.tscn".format([game_to_load]))
	get_tree().change_scene_to_file("res://scenes/{0}.tscn".format([game_to_load]))
