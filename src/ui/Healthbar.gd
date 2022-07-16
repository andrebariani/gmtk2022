extends Control


func set_health(health):
	for i in range(get_child_count()):
		get_child(i).visible = (i <= health-1)


func _on_Button_button_up():
	set_health((randi() % 4))
