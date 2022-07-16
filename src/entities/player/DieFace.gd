extends Node

const FACE_ENEMIES = [Constants.MELEE, Constants.RANGED, Constants.SUPPORT,
					Constants.MELEE, Constants.RANGED, Constants.SUPPORT]

var faces = [1, 4, 2, 3, 5, 6]
enum { TOP, LEFT, FRONT, RIGHT, BEHIND, DOWN }


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


func get_face(face):
	return faces[face]

func get_current_face():
	return get_face(TOP)

func get_enemy_type(face):
	return FACE_ENEMIES[get_face(face)]

func get_current_enemy_type():
	return get_enemy_type(TOP)

