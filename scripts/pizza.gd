extends Node2D

@onready var pizza_area: Area2D = $Area2D

const TOPPINGS = [
	preload("res://scenes/mushroom.tscn"),
	preload("res://scenes/pepperoni.tscn")
]

const MAX_RADIUS = 50
var MAX_TOPPINGS = randi_range(7, 9)

var blacklisted_locations = []
var child_toppings = []
var total_clicked = 0
var moused_over = false
var mouse_pos = Vector2.ZERO
var difference = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	for i in range(0, MAX_TOPPINGS):
		var type = randi() % TOPPINGS.size()
		var location
		
		for retries in range(0, 10):	#Retry the location 10 times before giving up
			location = _get_topping_location()
			if not _is_in_blacklisted_range(location):
				break
				
		var scene = TOPPINGS[type].instantiate()
		scene.position = location
	
		add_child(scene)
		scene.clicked.connect(_on_topping_clicked)
		child_toppings.append(scene)
		blacklisted_locations.append(location)

func _get_topping_location():
	var location = Vector2()
	var theta = randf() * 2 * PI	# Get the angle of topping about the center of pizza
	print("DEBUG: Angle is ", theta)
	var radius = randi_range(0, MAX_RADIUS)
	location.x = radius * cos(theta)
	location.y = radius * sin(theta)
	return location

func _is_in_blacklisted_range(location):
	for loc in blacklisted_locations:
		var diff_x = abs(location.x - loc.x)
		var diff_y = abs(location.y - loc.y)
		
		if diff_x < 8 or diff_y < 8:
			return true
	return false

func _on_topping_clicked():
	total_clicked += 1
	print("DEBUG: Total Clicked = ", total_clicked)
	if total_clicked == MAX_TOPPINGS:
		pizza_area.set_pickable(true)

func _inside_collision():
	moused_over = true
	print("DEBUG: Inside collision")

func _exit_collision():
	moused_over = false
	print("DEBUG: Exiting collision")
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	difference = mouse_pos - get_global_mouse_position()
	
	if (
		Input.is_action_pressed("m1_click") 
		and moused_over 
		and difference != Vector2.ZERO
	):
		global_position -= difference
	
	mouse_pos = get_global_mouse_position()
