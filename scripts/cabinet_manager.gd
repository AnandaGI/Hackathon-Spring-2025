extends Node

@onready var cabinet_manager: Node2D = %CabinetManager

const ARCADE_MACHINE = preload("res://scenes/arcade_machine.tscn")
const MACHINES = ["pizza", "jump", "plinko", "rhythm"]

var x_location = 0
signal cabinet_activated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(MACHINES)):
		var machine = ARCADE_MACHINE.instantiate()
		machine.activated.connect(_on_cabinet_activated)
		machine.position = Vector2(x_location, 0)
		machine.get_node("AnimatedSprite2D").play(MACHINES[i])
		add_child(machine)
		
		x_location += 125

func _on_cabinet_activated(game_to_load):
	print(
		"DEBUG: Cabinet Manager recieved cabinet activated signal with game: ", game_to_load)
	cabinet_activated.emit(game_to_load)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
