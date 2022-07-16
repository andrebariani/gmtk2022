extends Node2D


onready var ui = $CanvasLayer/UI
onready var shaders = $CanvasLayer/ScreenShaders
onready var player = $YSort/Player
onready var camera = $YSort/Player/Camera
onready var gameOverUI = $CanvasLayer/GameOver

var score = 0
var game_over = false

func _enter_tree():
	randomize()
	PlayerReference.set_player($YSort/Player)


func _ready():
	get_tree().paused = false
	Input.set_custom_mouse_cursor(GlobalNode.game_mouse)


func _input(event):
	if game_over and event is InputEventKey and event.pressed:
		get_tree().reload_current_scene()


func add_score(value):
	score += value
	ui.set_score(score)


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


func _on_Player_enemy_killed():
	add_score(1)


func _on_Player_advanced_combo(face):
	add_score(2)
	ui.set_next_combo_face(face)


func _on_Player_triggered_combo():
	add_score(18)
	ui.trigger_combo()


func _on_Player_died():
	get_tree().paused = true
	gameOverUI.game_over(score, 
		player.get_global_transform_with_canvas().origin / get_viewport_rect().size)


func _on_ScoreTimer_timeout():
	add_score(1)


func _on_GameOver_game_over_finished():
	game_over = true
