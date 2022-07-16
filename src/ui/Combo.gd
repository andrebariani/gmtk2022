extends Control

onready var back = $Back
onready var popper = $Popper
onready var tween = $Tween

func set_next_combo_face(next_face_texture):
	back.visible = true
	back.texture = popper.texture
	popper.texture = next_face_texture
	
	tween.interpolate_property(popper, "rect_scale", 
	Vector2(0, 0), Vector2(1, 1), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()


func trigger_combo():
	back.visible = false
	tween.interpolate_property(popper, "rect_position", 
		Vector2(0, 0), Vector2(305, 0), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN, 0.1)
	tween.interpolate_property(popper, "rect_position", 
		Vector2(305, 0), Vector2(0, 0), 0.25, Tween.TRANS_BACK, Tween.EASE_IN, 0.45)
	
	tween.interpolate_property(popper, "rect_rotation", 
		0, 360, 0.4, Tween.TRANS_BACK)
	tween.start()


func _on_Button_button_up():
	pass # Replace with function body.
