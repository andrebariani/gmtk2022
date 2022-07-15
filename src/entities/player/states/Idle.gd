extends State
	
func run(_delta):
	if e.get_input('dirv') != Vector2.ZERO:
		end("Move")
	elif e.get_input('roll'):
		end("roll")
