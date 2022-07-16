extends State
	
func run(delta):
	if !e.enablers.move:
		end("Idle")
		return
	
	e.apply_velocity(e.get_input('dirv') * delta)
	
	if e.get_input('dirv') == Vector2.ZERO:
		end("Idle")
	elif e.get_input('roll'):
		end("Roll")
	elif e.get_input('charge'):
		end("Load")
