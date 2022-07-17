extends Node2D


func _ready():
	for i in range(get_child_count()-1):
		get_child(i).position += Vector2(rand_range(-5, 5), rand_range(-5, 5))


func _on_AnimationPlayer_animation_finished(_anim_name):
	self.queue_free()
