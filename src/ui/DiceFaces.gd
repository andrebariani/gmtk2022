extends Control

export var face_distance = 75
export var duration = 0.5

onready var face_positions = {
	Constants.TOP:[Vector2(0, 0), Vector2(1, 1)],
	Constants.DOWN:[Vector2(10, 10), Vector2(0.5, 0.5)],
	Constants.LEFT:[Vector2(-face_distance, 0), Vector2(1, 1)],
	Constants.RIGHT:[Vector2(face_distance, 0), Vector2(1, 1)],
	Constants.BEHIND:[Vector2(0, -face_distance), Vector2(1, 1)],
	Constants.FRONT:[Vector2(0, face_distance), Vector2(1, 1)]
	}

onready var tween = $Tween

func set_current_faces(top, behind, front, left, right, down):
	interpolate_die(top, Constants.TOP)
	interpolate_die(behind, Constants.BEHIND)
	interpolate_die(front, Constants.FRONT)
	interpolate_die(left, Constants.LEFT)
	interpolate_die(right, Constants.RIGHT)
	interpolate_die(down, Constants.DOWN)
	
	move_child(get_node(str(down)), 0)
	tween.start()


func interpolate_die(index, target):
	tween.interpolate_property(get_node(str(index)), "rect_position",
		null, face_positions[target][0], duration,
		tween.TRANS_BACK)
	tween.interpolate_property(get_node(str(index)), "rect_scale",
		null, face_positions[target][1], duration,
		tween.TRANS_BACK)


func _on_Button_button_up():
	set_current_faces(3, 5, 2, 1, 6, 4)
