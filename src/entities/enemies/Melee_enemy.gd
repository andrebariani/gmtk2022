extends "res://src/entities/enemies/Enemy_chaser.gd"

var in_range = false
export (float) var charge_mult
var charge_direction

func _ready():
	$Hitbox/CollisionShape2D.disabled = true

func on_process(delta):
	if movement_status == KNOCKBACK:
		movimentation(delta)
		return
	
	if movement_status == NORMAL:
		movimentation(delta)
		if in_range:
			movement_status = CHARGING
			$Timer_charging.start()
	elif movement_status == CHARGING:
		move_and_slide(-global_position.direction_to(Player.global_position) * speed * delta / 100)
	elif movement_status == CHARGE:
		move_and_slide(charge_direction * speed * delta * charge_mult)

func _on_Range_body_entered(_body):
	in_range = true

func _on_Range_body_exited(_body):
	in_range = false


func _on_Timer_charging_timeout():
	if movement_status != KNOCKBACK:
		movement_status = CHARGE
		$Hitbox/CollisionShape2D.disabled = false
		charge_direction = global_position.direction_to(Player.global_position)
		$Timer_charge.start()

func _on_Timer_charge_timeout():
	if movement_status != KNOCKBACK:
		$Hitbox/CollisionShape2D.disabled = true
		movement_status = NORMAL
		
