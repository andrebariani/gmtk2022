extends State

signal rolled

var orientation = Vector2.ZERO

func begin():
	if !e.enablers.roll:
		end(stateMachine.state_last)
		return
		
	e.timers.roll.value = 0
	
	e.current_speed = e.roll_speed
	e.has_dir_control = false
	
	orientation = e.ori
	if orientation.x < 0:
		e.dieFaces.roll_left()
	elif orientation.x > 0:
		e.dieFaces.roll_right()
	elif orientation.y < 0:
		e.dieFaces.roll_up()
	else:
		e.dieFaces.roll_down()
	
	emit_signal("rolled")


func run(delta):
	if orientation.x != 0:
		e.apply_velocity(orientation.x * delta)
	else:
		e.apply_velocity(orientation.y * delta)
	
	if e.timers.roll.is_over():
		if e.get_input('dirv'):
			end("Move")
		else:
			end("Idle")


func before_end(_next_state: String):
	e.current_speed = e.walk_speed
	e.has_dir_control = true
