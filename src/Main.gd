extends Node2D


onready var ui = $CanvasLayer/UI
onready var shaders = $CanvasLayer/ScreenShaders
onready var player = $YSort/Player
onready var camera = $YSort/Player/Camera
onready var gameOverUI = $CanvasLayer/GameOver
onready var heyFellaLabel = $CanvasLayer/HeyFella/Label

var score = 0
var game_over = false

var enemy_types_killed = []

func _enter_tree():
	randomize()
	PlayerReference.set_player($YSort/Player)


func _ready():
	get_tree().paused = false
	gameOverUI.begin(player.get_global_transform_with_canvas().origin / 
		get_viewport_rect().size)
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
	
	GlobalNode.current_color = faces.get_current_enemy_type()
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.set_highlighted_color(GlobalNode.current_color)
	
	camera.shake_camera(80)


func _on_Player_health_changed(value):
	ui.set_health(value)


func _on_Player_enemy_hit():
	camera.shake_camera(100)


func _on_Player_enemy_killed():
	var enemy_killed = player.dieFaces.get_current_enemy_type()
	if !enemy_types_killed.has(enemy_killed):
		enemy_types_killed.append(enemy_killed)
		if enemy_types_killed.size() >= 3:
			heyFellaLabel.text = "Hit enemies with ascending numbers to perform a Combo!"
	camera.shake_camera(300)
	add_score(1)


func _on_Player_advanced_combo(face):
	ui.set_next_combo_face(face)


func _on_Player_triggered_combo():
	camera.shake_camera(600)
	add_score(18)
	ui.trigger_combo()


func _on_Player_took_damage():
	camera.shake_camera(400)

func _on_Player_died():
	get_tree().paused = true
	gameOverUI.game_over(score, 
		player.get_global_transform_with_canvas().origin / get_viewport_rect().size)


func _on_ScoreTimer_timeout():
	add_score(1)


func _on_GameOver_game_over_finished():
	game_over = true
