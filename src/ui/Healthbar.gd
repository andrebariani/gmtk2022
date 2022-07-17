extends Control

onready var tween = $Tween
onready var hps = $Slots

func set_health(health):
	for i in range(hps.get_child_count()):
		if i <= health-1:
			if !hps.get_child(i).visible:
				hps.get_child(i).visible = true
				tween.interpolate_property(hps.get_child(i), 'rect_scale', 
					null, Vector2(2, 2), 0.1, Tween.TRANS_BACK, Tween.EASE_IN)
		else:
			if hps.get_child(i).visible:
				tween.interpolate_property(hps.get_child(i), 'rect_scale', 
					null, Vector2(0, 0), 0.1, Tween.TRANS_BACK, Tween.EASE_IN)
				tween.interpolate_property(hps.get_child(i), 'visible',
					null, false, 0.1, Tween.TRANS_BACK, Tween.EASE_IN, 0.1)
		
		tween.start()


func _on_Button_button_up():
	set_health((randi() % 4))
