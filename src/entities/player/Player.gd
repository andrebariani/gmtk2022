extends KinematicBody2D
class_name Player

export var debug = false

var current_speed = 100
export (int) var WALK_SPEED = 600
onready var walk_speed = WALK_SPEED
var ori: Vector2
var has_dir_control = true
var knockback = Vector2.ZERO

export (int) var ROLL_SPEED = 1200
export (int) var ROLL_FRAMES = 15
onready var roll_speed = ROLL_SPEED
var is_rolling = false


var look_vector = Vector2.ZERO

onready var inputHelper = $Inputs
onready var stateMachine = $StateMachine
onready var _sprite = $Sprite
onready var _hurtbox = $Hurtbox

onready var timers = {
	"roll": PlayerTimer.new(ROLL_FRAMES)
}

var enablers = {
	move = true,
	attack = true,
	shoot = true,
	roll = true,
	string = true
}

func _ready():
	current_speed = walk_speed
	inputHelper.init(self)
	stateMachine.init(self)


func _physics_process(delta):
	look_vector = get_global_mouse_position() - global_position
	move_and_collide(knockback)
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
	update_timers()
	inputHelper.get_inputs()
	
	stateMachine.run(delta)
	
	if debug:
		pass


func apply_velocity(velocity):
	move_and_slide(current_speed * velocity)


func update_timers():
	for t in timers.values():
		t.tick()


func take_knockback(velocity):
	knockback += velocity
	

func get_input(key):
	return inputHelper.inputs[key]


func set_enabler(enabler, value):
	enablers[enabler] = value


func set_input_disabled(value):
	inputHelper.disabled = value


func approach(a, b, amount):
	if (a < b):
		a += amount
		if (a > b):
			return b
	else:
		a -= amount
		if(a < b):
			return b
	return a


func player():
	# DONT DELETE THIS
	# ?!?!?!?!?!??!!  W H Y
	pass
