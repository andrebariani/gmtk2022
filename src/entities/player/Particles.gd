extends Node2D


func _ready():
	scale = Vector2(rand_range(1, 2), rand_range(1, 2))


func _on_AnimationPlayer_animation_finished(_anim_name):
	self.queue_free()
