extends Node2D


onready var ui = $CanvasLayer/UI
onready var player = $Player


func _on_Player_rolled():
	var faces = player.dieFaces
	ui.set_current_faces(faces.get_face(faces.TOP), 
		faces.get_face(faces.BEHIND),
		faces.get_face(faces.FRONT), 
		faces.get_face(faces.LEFT), 
		faces.get_face(faces.RIGHT))
