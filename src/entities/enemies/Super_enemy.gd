extends Node2D

var current_enemy

# onready var melee_sprite = preload("")
# onready var ranged_sprite = preload("")
# onready var protector_sprite = preload("")

onready var melee_enemy = preload("res://src/entities/enemies/Melee_enemy.tscn")
onready var ranged_enemy = preload("res://src/entities/enemies/Ranged_enemy.tscn")
onready var protector_enemy = preload("res://src/entities/enemies/Protector_enemy.tscn")
export(PackedScene) var black_chip

func _ready():
	current_enemy = melee_enemy.instance()
	# current_enemy.sprite.texture = melee_sprite
	current_enemy.global_position = global_position
	current_enemy.connect("enemy_died", self, "_on_enemy_melee_death")
	get_parent().call_deferred("add_child", current_enemy)
	add_black_chip(current_enemy)


func add_black_chip(enemy):
	var chip = black_chip.instance()
	enemy.call_deferred("add_child", chip)

func _on_enemy_melee_death():
	var spawn_pos = current_enemy.global_position
	current_enemy = ranged_enemy.instance()
	# current_enemy.sprite.texture = ranged_sprite
	current_enemy.animation_name = "RESET"
	current_enemy.global_position = spawn_pos
	current_enemy.connect("enemy_died", self, "_on_enemy_ranged_death")
	get_parent().call_deferred("add_child", current_enemy)
	add_black_chip(current_enemy)

func _on_enemy_ranged_death():
	var spawn_pos = current_enemy.global_position
	current_enemy = protector_enemy.instance()
	# current_enemy.sprite.texture = protector_sprite
	current_enemy.animation_name = "RESET"
	current_enemy.global_position = spawn_pos
	current_enemy.connect("enemy_died", self, "_on_enemy_protector_death")
	get_parent().call_deferred("add_child", current_enemy)
	add_black_chip(current_enemy)

func _on_enemy_protector_death():
	queue_free()
