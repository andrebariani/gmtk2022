extends "res://src/entities/enemies/Enemy_base.gd"


func _on_Protect_range_body_entered(body):
	body.protections += 1

func _on_Protect_range_body_exited(body):
	body.protections -= 1
