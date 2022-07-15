extends State

func begin():
	if !e.enablers.roll:
		end(stateMachine.state_last)
		return
		
	e.timers.roll.value = 0
	
	e.current_speed = e.roll_speed
	e.has_dir_control = false


func run(delta):
	e.apply_velocity(e.ori * delta)
	
	if e.timers.roll.is_over():
		if e.get_input('dirv'):
			end("Move")
		else:
			end("Idle")


func before_end(_next_state: String):
	e.current_speed = e.walk_speed
	e.has_dir_control = true
