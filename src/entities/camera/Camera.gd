extends Camera2D

const MAX_CAMERA_PERCENT = 0.1
const MAX_CAMERA_DISTANCE = 50.0

export var shake_duration = 0.25
var center_position = Vector2.ZERO

var shake = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = shake_duration

func _process(_delta):
	var viewport = get_viewport()
	var viewport_center = viewport.size / 2.0
	var mouse_to_center = viewport.get_mouse_position() - viewport_center
	var percent = (mouse_to_center / (viewport.size * 2.0)).length()
	if percent > MAX_CAMERA_PERCENT:
		percent = MAX_CAMERA_PERCENT
	
	var distance = MAX_CAMERA_DISTANCE * (percent / MAX_CAMERA_PERCENT)
	center_position = mouse_to_center.normalized() * distance
	
	if (shake <= 0):
		position = center_position
		return
	
	position += Vector2(rand_range(-shake, shake), rand_range(-shake, shake))

func shake_camera(level):
	shake = level
	$Timer.start()


func _on_Timer_timeout():
	shake = 0
	position = Vector2.ZERO
