extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect('mouse_entered', self, 'on_mouse_entered')


func on_mouse_entered():
	pass
