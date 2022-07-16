extends "res://src/entities/enemies/Enemy_base.gd"

func movimentation(delta):
	if movement_status == NORMAL:
		# var dodge_rotation = get_angle_to_dodge_obstacles($CollisionShape2D.shape.radius, 100)
		move_and_slide(global_position.direction_to(Player.global_position) * speed * delta)
	elif movement_status == KNOCKBACK:
		var mult = $Knockback_timer.time_left / $Knockback_timer.wait_time
		move_and_slide((knockback_vector * mult) * delta)
