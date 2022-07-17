extends Node

signal on_cutscene_changed(in_cutscene)

var sound_volume = 25
var music_volume = 20
var current_stage = 0
var should_advance_stage = false

var current_color = 0

var _in_cutscene = false
func set_in_cutscene(value):
	_in_cutscene = value
	emit_signal("on_cutscene_changed", value)

onready var menu_mouse = preload("res://assets/sprites/pointers/pointer_2.png")
onready var game_mouse = preload("res://assets/sprites/pointers/mira.png")
onready var time_mouse = preload("res://assets/sprites/pointers/hourglass.png")
