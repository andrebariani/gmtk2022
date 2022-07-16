extends Node

const FACE_ENEMIES = [Constants.MELEE, Constants.RANGED, Constants.SUPPORT,
					Constants.MELEE, Constants.RANGED, Constants.SUPPORT]

var faces = [1, 4, 2, 3, 5, 6]


func roll_left():
	var f = faces.duplicate()
	faces[Constants.LEFT] = f[Constants.TOP]
	faces[Constants.TOP] = f[Constants.RIGHT]
	faces[Constants.RIGHT] = f[Constants.DOWN]
	faces[Constants.DOWN] = f[Constants.LEFT]

func roll_down():
	var f = faces.duplicate()
	faces[Constants.FRONT] = f[Constants.TOP]
	faces[Constants.TOP] = f[Constants.BEHIND]
	faces[Constants.BEHIND] = f[Constants.DOWN]
	faces[Constants.DOWN] = f[Constants.FRONT]

func roll_right():
	var f = faces.duplicate()
	faces[Constants.RIGHT] = f[Constants.TOP]
	faces[Constants.TOP] = f[Constants.LEFT]
	faces[Constants.LEFT] = f[Constants.DOWN]
	faces[Constants.DOWN] = f[Constants.RIGHT]

func roll_up():
	var f = faces.duplicate()
	faces[Constants.BEHIND] = f[Constants.TOP]
	faces[Constants.TOP] = f[Constants.FRONT]
	faces[Constants.FRONT] = f[Constants.DOWN]
	faces[Constants.DOWN] = f[Constants.BEHIND]


func get_face(face):
	return faces[face]

func get_current_face():
	return get_face(Constants.TOP)

func get_enemy_type(face):
	return FACE_ENEMIES[get_face(face)-1]

func get_current_enemy_type():
	return get_enemy_type(Constants.TOP)

