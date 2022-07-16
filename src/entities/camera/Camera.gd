extends Camera2D

export var shake_duration = 0.25
var center_position = Vector2.ZERO

var shake = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = shake_duration

func _process(_delta):
	if (shake <= 0):
		return
	
	position = (center_position + 
		Vector2(rand_range(-shake, shake), rand_range(-shake, shake)))

func shake_camera(level):
	shake = level
	$Timer.start()


func _on_Timer_timeout():
	shake = 0
	position = Vector2.ZERO
