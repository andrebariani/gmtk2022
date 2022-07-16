extends Sprite

export(Color) var blink_color = Color(0.569, 0.227, 0.321)
onready var blink_vector = Vector3(blink_color.r, blink_color.g, blink_color.b)

var blink_count = 10

func _ready():
	set_blink_active(false)
	set_blink_color(blink_vector)


func blink_anim():
	set_blink_color(blink_vector)
	for i in range(blink_count):
		$Tween.interpolate_callback($".", i*0.2, "set_blink_active", true)
		$Tween.interpolate_callback($".", i*0.2 + 0.1, "set_blink_active", false)
	$Tween.start()


func stop_anim():
	$Tween.stop_all()
	set_blink_active(false)


func set_blink_color(color):
	material.set_shader_param("color", color)


func set_blink_active(blink):
	material.set_shader_param("active", blink)


func _on_Button_pressed():
	blink_anim()


func _on_Tween_tween_all_completed():
	pass # Replace with function body.
