extends TextureRect

onready var popper = $Popper
onready var tween = $Tween

func set_next_combo_face(next_face_texture):
	texture = popper.texture
	popper.texture = next_face_texture
	
	tween.interpolate_property(popper, "rect_scale", 
	Vector2(0, 0), Vector2(1, 1), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()





func _on_Button_button_up():
	pass # Replace with function body.
