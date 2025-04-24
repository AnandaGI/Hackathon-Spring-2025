extends Node2D

@onready var count_down: Timer = $CountDown
@onready var count_down_label: Label = $CountDownLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var time_left = 60

func _ready():
	count_down_label.text = format_time(time_left)
	count_down.start()
	
func _on_timer_timeout():
	if time_left > 0:
		time_left -= 1
		count_down_label.text = format_time(time_left)
	else:
		count_down_label.text = "Time's up!"
		
func format_time(seconds):
	var mins = int(seconds / 60)
	var secs = int(seconds % 60)
	var mins_str = str(mins)
	var secs_str = str(secs)
	
	if mins < 10:
		mins_str = "0" + mins_str
	if secs < 10:
		secs_str = "0" + secs_str
		
	return mins_str + ":" + secs_str
