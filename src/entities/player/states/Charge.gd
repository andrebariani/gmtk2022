extends State

var look_vector

func begin():
	if !e.enablers.charge:
		end("Idle")
		return
	
	look_vector = (e.get_global_mouse_position() - e.global_position).normalized()


func run(delta):
	e.apply_velocity(look_vector * e.CHARGE_SPEED * delta)
	
	e.load_amount -= delta
	if e.load_amount <= 0:
		if e.get_input('dirv') == Vector2.ZERO:
			end("Idle")
		else:
			end("Move")
