extends Control
class_name Menu

var flicker = true
var play = true

func _ready():
	if !Transitions.is_connected("transition_finished", self, "transition_finished"): 
		Transitions.connect("transition_finished", self, "transition_finished")

func _on_Options_button_up():
	if $Options.visible:
		$AnimationPlayer.play("OptionsOpen")
	else:
		if flicker:
			$AnimationPlayer.play("OptionsOpen")
		else:
			$AnimationPlayer.play("OptionsOpenNormal")
	flicker = false


func _on_Quit_button_up():
	play = false
	Transitions.play("CloseFromLeft")


func _on_Close_button_up():
	$AnimationPlayer.play("OptionsClose")


func transition_finished(_anim_name):
	pass


func _on_Sound_value_changed(value):
	GlobalNode.sound_volume = value


func _on_Music_value_changed(value):
	GlobalNode.music_volume = value
