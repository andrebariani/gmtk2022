extends Node2D


onready var ui = $CanvasLayer/UI
onready var player = $Player
onready var camera = $Player/Camera

func _on_Player_rolled(direction):
	var faces = player.dieFaces
	ui.set_current_faces(faces.get_face(Constants.TOP), 
		faces.get_face(Constants.BEHIND),
		faces.get_face(Constants.FRONT), 
		faces.get_face(Constants.LEFT), 
		faces.get_face(Constants.RIGHT),
		faces.get_face(Constants.DOWN))
	
	camera.shake_camera(80)
