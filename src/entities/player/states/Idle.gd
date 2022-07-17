extends State

onready var dice_animation = get_node("../../Sprite/DiceAnimation")

func run(_delta):
	if e.get_input('dirv') != Vector2.ZERO:
		end("Move")
	elif e.get_input('roll'):
		end("Roll")
	elif e.get_input('charge'):
		end("Load")
		
	dice_animation.reset_animation()
