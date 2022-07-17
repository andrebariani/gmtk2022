extends Node2D

var spawn_width
var spawn_height
const SPAWN_DELAY = 10

onready var player = PlayerReference.get_player()
onready var spawn_blocker = get_node("Spawn_blocker")
onready var rng = RandomNumberGenerator.new()

export(NodePath) var ysort_path
onready var ysort = get_node(ysort_path)

var support_enemies = [
	preload('res://src/entities/enemies/Protector_enemy.tscn')
]
var attack_enemies = [
	preload('res://src/entities/enemies/Ranged_enemy.tscn'),
	preload('res://src/entities/enemies/Melee_enemy.tscn')
]

var game_time = 0
var qnt_enemies_alive = 0


func _ready():
	$Timer.start(SPAWN_DELAY)
	rng.randomize()
	
	# Definindo o tamanho do spawn blocker para que inimigos não spawnem no campo de visão do player + EXTRA_SPACE
	spawn_blocker.shape.extents.x = ProjectSettings.get_setting("display/window/size/width") / 3
	spawn_blocker.shape.extents.y = ProjectSettings.get_setting("display/window/size/height") / 3
	spawn_width = $Spawn_area/CollisionShape2D.shape.extents.x * 2
	spawn_height = $Spawn_area/CollisionShape2D.shape.extents.y * 2
	
	spawn_enemies()

func _process(_delta):
	position = player.global_position

func _on_Timer_timeout():
	spawn_enemies()
	$Timer.start(SPAWN_DELAY)

func spawn_enemies():
	var qnt_attack_enemies = round(game_time / 30) + 2
	var qnt_support_enemies = round(game_time / 60)
	qnt_enemies_alive += qnt_attack_enemies + qnt_support_enemies
	
	for _i in range(qnt_attack_enemies):
		var selected = attack_enemies[rng.randi_range(0, len(attack_enemies) - 1)]
		spawn_enemy(selected)
	
	for _i in range(qnt_support_enemies):
		var selected = support_enemies[rng.randi_range(0, len(support_enemies) - 1)]
		spawn_enemy(selected)

func spawn_enemy(Enemy):
	var enemy = Enemy.instance()
	ysort.call_deferred("add_child", enemy)
	enemy.position = get_random_position(enemy.get_node("CollisionShape2D").shape)
	enemy.connect("enemy_died", self, "_on_enemy_death", [enemy])

func get_random_position(enemy_colision_shape):
	# Retorna uma posição aleatória dentro do range do retangulo de largura 
	# e altura definidos pelas constantes no começo do código.
	# A posição retornada precisa estar livre (sem nenhum objeto com colisão nela)
	
	var space_state = get_world_2d().direct_space_state
	
	while true: # Enquanto a posição aleatória não for livre, irá ficar sorteando uma nova.
		var random_pos = Vector2(rng.randf_range(-spawn_width/2,spawn_width/2), rng.randf_range(-spawn_height/2,spawn_height/2))
		
		var query = Physics2DShapeQueryParameters.new()
		query.collision_layer = 0b00000001000000000000
		query.collide_with_areas = true
		query.set_shape(enemy_colision_shape)
		query.set_transform(Transform2D(0, random_pos))
		
		if not space_state.collide_shape(query,1):
			return random_pos

func _on_enemy_death(_enemy):
	qnt_enemies_alive -= 1
	if qnt_enemies_alive == 0:
		$Timer.start(min($Timer.time_left, 2))


func _on_Game_timer_timeout():
	game_time += 1
