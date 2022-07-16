extends State

signal rolled(direction)

var orientation = Vector2.ZERO

func begin():
	if !e.enablers.roll:
		end(stateMachine.state_last)
		return
	
	e.spawn_dust(3)
	e.timers.roll.value = 0
	
	e.current_speed = e.roll_speed
	e.has_dir_control = false
	
	orientation = e.ori
	if orientation.x < 0:
		emit_signal("rolled", Constants.LEFT)
	elif orientation.x > 0:
		emit_signal("rolled", Constants.RIGHT)
	elif orientation.y < 0:
		emit_signal("rolled", Constants.FRONT)
	else:
		emit_signal("rolled", Constants.BEHIND)


func run(delta):
	if orientation.x != 0:
		orientation.y = 0
	e.apply_velocity(orientation * delta)
	
	if e.timers.roll.is_over():
		if e.get_input('dirv'):
			end("Move")
		else:
			end("Idle")


func before_end(_next_state: String):
	e.current_speed = e.walk_speed
	e.has_dir_control = true
