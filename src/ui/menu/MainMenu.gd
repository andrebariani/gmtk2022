extends Menu

var play_flicker = true
var tutorial = false

func _ready():
	Input.set_custom_mouse_cursor(GlobalNode.menu_mouse)
	._ready()


func _on_Play_button_up():
	play = true
	GlobalNode.current_stage = 0
	GlobalNode.should_advance_stage = false
	Transitions.play("CloseFromLeft")


func _on_Tutorial_button_up():
	play = true
	tutorial = true
	GlobalNode.should_advance_stage = false
	Transitions.play("CloseFromLeft")


func _on_CloseLevel_button_up():
	$AnimationPlayer.play("StagesClose")


func transition_finished(anim_name):
	if anim_name == "CloseFromLeft" and visible:
		if tutorial:
			get_tree().change_scene("res://src/TutorialArea.tscn")
		elif play:
			get_tree().change_scene("res://src/stages/Swamp/Swamp.tscn")
		else:
			get_tree().quit()
