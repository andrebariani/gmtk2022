extends "res://src/entities/enemies/Enemy_chaser.gd"


func on_process(delta):
	if movement_status == KNOCKBACK:
		movimentation(delta/2)


func _on_Protect_range_body_entered(body):
	body.protections += 1
	if body.sprite.material != null:
		body.sprite.material.set_shader_param("active", true)


func _on_Protect_range_body_exited(body):
	body.protections -= 1
	if body.protections <= 0 and body.sprite.material != null:
		body.sprite.material.set_shader_param("active", false)


func _on_AnimationPlayer_animation_finished(anim_name):
	._on_AnimationPlayer_animation_finished(anim_name)
	$Light2D.visible = true
