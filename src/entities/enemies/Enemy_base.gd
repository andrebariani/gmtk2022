extends KinematicBody2D

var attributes = {}
onready var Player = get_parent().get_node("Player")
onready var collision_shape = $CollisionShape2D.shape
export (float) var speed
export (bool) var protector
export (int) var color
enum {NORMAL, KNOCKBACK}
var movement_status = NORMAL
var protected = false

signal enemy_died(enemy)

func on_ready():
	pass

func on_process(delta):
	pass

func _process(delta):
	on_process(delta)


func _ready():
	var enemies_spawner = get_parent().get_node("Enemies_spawner")
	
	connect("enemy_died", enemies_spawner, "_on_enemy_death", [self])
	on_ready()


func die():
	emit_signal("enemy_died")
	queue_free()


func verify_colision(space_state, width, height, angle, rotate):
	# Verifica se há ocorrerá colisão a frente (rotacionado em angle).
	# width e height estão relacionados ao retângulo de colisão que será criado para verificar
	# a colisão
	# Se ocorrer uma colisão, o retorno é true, caso contrário é false.
	
	var query = Physics2DShapeQueryParameters.new()
	query.collision_layer = 0b00000000001000000000
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(width, height)
	query.set_shape(shape)
	query.transform = Transform2D(rotate + deg2rad(angle), global_position + Vector2(0, -height).rotated(rotation + deg2rad(angle)))
	# Transform2D(rotation + deg2rad(angle), global_position + Vector2(0, -height).rotated(rotation + deg2rad(angle)))
	return len(space_state.collide_shape(query, 1)) != 0

func get_angle_to_dodge_obstacles(width, height, rotate = rotation):
	# Tenta retornar um angulo para o desvio de obstaculos
	# Width e heigth estão relacionados aos retângulos de colisão que serão criados
	# para verificar obstaculos. Width deve ser da largura do inimigo e height
	# quanto maior for, o inimigo detectará antes o obstaculo
	var space_state = get_world_2d().direct_space_state
	
	if not verify_colision(space_state, width, height, 0, rotate):
		return 0
	
	for angle in range(5, 91, 5):
		if not verify_colision(space_state, width, height, angle, rotate):
			return angle
	
	for angle in range(-5, -91, -5):
		if not verify_colision(space_state, width, height, angle, rotate):
			return angle
	
	return 0



func _on_Hurtbox_area_entered(area):
	var current_player_color = area.get_parent().get_current_color()
	
	if current_player_color == color and (protector or not protected):
		die()
	else:
		movement_status = KNOCKBACK
		$Knockback_timer.start()


func _on_Knockback_timer_timeout():
	movement_status = NORMAL
