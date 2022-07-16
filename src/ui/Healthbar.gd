extends Control

onready var tween = $Tween

func set_health(health):
	for i in range(get_child_count()-1):
		if i <= health-1:
			if !get_child(i).visible:
				get_child(i).visible = true
				tween.interpolate_property(get_child(i), 'rect_scale', 
					null, Vector2(1, 1), 0.1, Tween.TRANS_BACK, Tween.EASE_IN)
		else:
			if get_child(i).visible:
				tween.interpolate_property(get_child(i), 'rect_scale', 
					null, Vector2(0, 0), 0.1, Tween.TRANS_BACK, Tween.EASE_IN)
				tween.interpolate_property(get_child(i), 'visible',
					null, false, 0.1, Tween.TRANS_BACK, Tween.EASE_IN, 0.1)
		
		tween.start()


func _on_Button_button_up():
	set_health((randi() % 4))
