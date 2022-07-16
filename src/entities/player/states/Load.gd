extends State

export var shake_amount = 20
export var shake_frequency = 50
var shaking = false
var load_min = 0.25
var load_max = 0.75

var clock = 0
var center = Vector2.ZERO
var target_position = Vector2.ZERO

func begin():
	if !e.enablers.charge:
		end("Idle")
		return
	
	center = e.position
	shaking = true


func run(delta):
	if shaking:
		e.load_amount += delta
		if e.load_amount > load_max:
			e.load_amount = load_max
			#target_position = center
			shaking = false
		
		clock += delta
		if clock > load_max/shake_frequency:
			clock = 0
			target_position = center + Vector2(rand_range(-shake_amount, shake_amount),
									rand_range(-shake_amount, shake_amount))
	
		e.position = lerp(e.position, target_position, delta)
	
	
	if e.get_input('charge_released'):
		if e.load_amount < load_min:
			e.load_amount = load_min
		end("Charge")
