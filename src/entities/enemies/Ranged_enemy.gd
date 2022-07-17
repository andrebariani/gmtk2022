extends EnemyChaser

var aiming = false
var in_range = false
const BULLET_WIDTH = Vector2(10,0)

export var TIME_TO_SHOOT = 2

# onready var shoot_animation = $ShootAnimation
onready var Bullet = preload("res://src/entities/enemies/Bullet.tscn")
onready var BulletSprite = $Sprite/BulletSprite

func on_process(delta):
	movimentation(delta)
	if movement_status == KNOCKBACK:
		aiming = false
		return
	
	if aiming:
		if not is_path_to_player_free():
			movement_status = NORMAL
			$Timer_shoot.stop()
			aiming = false
	elif in_range:
		if is_path_to_player_free():
			movement_status = STOP
			BulletSprite.visible = true
			$Timer_shoot.start(TIME_TO_SHOOT)
			aiming = true


func is_path_to_player_free():
	var space_state = get_world_2d().direct_space_state
	var result1 = space_state.intersect_ray(global_position + BULLET_WIDTH.rotated(rotation),\
				  Player.global_position + BULLET_WIDTH.rotated(rotation), [self, Player], 0b00000000001000000000)
	var result2 = space_state.intersect_ray(global_position - BULLET_WIDTH.rotated(rotation),\
				  Player.global_position - BULLET_WIDTH.rotated(rotation), [self, Player], 0b00000000001000000000)
	return not result1 and not result2

func _on_Range_body_entered(_body):
	in_range = true

func _on_Range_body_exited(_body):
	in_range = false


func _on_Timer_shoot_timeout():
	if movement_status != KNOCKBACK:
		shoot()
	
	if not in_range:
		aiming = false
		$Timer_shoot.stop()
		if movement_status != KNOCKBACK:
			movement_status = NORMAL


func shoot():
	# shoot_animation.play("Shoot")
	$shoot.play()
	var bullet = Bullet.instance()
	bullet.initialize_bullet(BulletSprite.global_position, 
		BulletSprite.global_position.direction_to(Player.global_position))
	BulletSprite.visible = false
	get_parent().add_child(bullet)
