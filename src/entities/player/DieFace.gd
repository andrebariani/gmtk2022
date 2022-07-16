extends Node

var faces = [1, 4, 2, 3, 5, 6]
enum { TOP, LEFT, FRONT, RIGHT, BEHIND, DOWN }


func _ready():
	print_debug(get_current_face())
	roll_left()
	print_debug(get_current_face())
	roll_left()
	print_debug(get_current_face())
	roll_down()
	print_debug(get_current_face())
	roll_right()
	print_debug(get_current_face())
	roll_down()
	print_debug(get_current_face())
	roll_down()
	print_debug(get_current_face())
	roll_left()
	print_debug(get_current_face())
	roll_up()
	print_debug(get_current_face())


func roll_left():
	var f = faces.duplicate()
	faces[LEFT] = f[TOP]
	faces[TOP] = f[RIGHT]
	faces[RIGHT] = f[DOWN]
	faces[DOWN] = f[LEFT]

func roll_down():
	var f = faces.duplicate()
	faces[FRONT] = f[TOP]
	faces[TOP] = f[BEHIND]
	faces[BEHIND] = f[DOWN]
	faces[DOWN] = f[FRONT]


func roll_right():
	var f = faces.duplicate()
	faces[RIGHT] = f[TOP]
	faces[TOP] = f[LEFT]
	faces[LEFT] = f[DOWN]
	faces[DOWN] = f[RIGHT]


func roll_up():
	var f = faces.duplicate()
	faces[BEHIND] = f[TOP]
	faces[TOP] = f[FRONT]
	faces[FRONT] = f[DOWN]
	faces[DOWN] = f[BEHIND]



func get_current_face():
	return faces[TOP]
