extends Menu


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		Input.set_custom_mouse_cursor(GlobalNode.menu_mouse)
		$AnimationPlayer.play("Blackout")
	else:
		Input.set_custom_mouse_cursor(GlobalNode.game_mouse)
		$AnimationPlayer.play_backwards("Blackout")


func _on_Back_button_up():
	toggle_pause()


func _on_Menu_button_up():
	Transitions.play("CloseFromLeft")


func transition_finished(anim_name):
	if anim_name == "CloseFromLeft" and visible:
		get_tree().paused = false
		get_tree().change_scene("res://src/ui/menu/MainMenu.tscn")
