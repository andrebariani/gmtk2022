extends Node2D

var clock = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock += delta*1.5
	for child in get_children():
		child.energy = 0.5 + abs(sin(clock)*0.5)
