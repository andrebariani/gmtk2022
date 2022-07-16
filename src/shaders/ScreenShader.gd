extends Control


var enemies_to_int = {Constants.MELEE:0, Constants.RANGED:1, Constants.SUPPORT:2}


func set_current_color(enemy_type):
	$ScreenShader.material.set_shader_param("color", 
		enemies_to_int[enemy_type])


func game_over(player_screen_position):
	print_debug(player_screen_position)
	$GameOver.material.set_shader_param("center", player_screen_position)
	$GameOver/AnimationPlayer.play("GameOver")


func _on_Button_pressed():
	$ImpactShader.material.set_shader_param("center", 
	Vector2(rand_range(0, 1.0), rand_range(0, 1.0)))
	$ImpactShader/AnimationPlayer.play("Impact")
