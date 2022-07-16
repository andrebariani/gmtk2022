extends Node2D


onready var ui = $CanvasLayer/UI
onready var shaders = $CanvasLayer/ScreenShaders
onready var player = $YSort/Player
onready var camera = $YSort/Player/Camera


func _enter_tree():
	randomize()
	PlayerReference.set_player($YSort/Player)


func _on_Player_rolled(_direction):
	var faces : DieFaces = player.dieFaces
	ui.set_current_faces(faces.get_face(Constants.TOP), 
		faces.get_face(Constants.BEHIND),
		faces.get_face(Constants.FRONT), 
		faces.get_face(Constants.LEFT), 
		faces.get_face(Constants.RIGHT),
		faces.get_face(Constants.DOWN))
	shaders.set_current_color(faces.get_current_enemy_type())
	
	camera.shake_camera(80)


func _on_Player_health_changed(value):
	ui.set_health(value)


func _on_Player_advanced_combo(face):
	ui.set_next_combo_face(face)


func _on_Player_triggered_combo():
	ui.trigger_combo()
