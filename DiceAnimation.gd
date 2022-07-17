extends Node2D
class_name DiceAnimation

export var top_num: int = 1
export var front_num: int = 2

onready var curr_face: Node2D = $CurrentFace
onready var curr_face_top: Sprite = $CurrentFace/Top
onready var curr_face_top_num: Sprite = $CurrentFace/Top/Number
onready var curr_face_front: Sprite = $CurrentFace/Front
onready var curr_face_front_num: Sprite = $CurrentFace/Front/Number

onready var old_face_top: Sprite = $NextFaceAnimation/Old
onready var old_face_top_num: Sprite = $NextFaceAnimation/Old/OldNumber
onready var old_face_front: Sprite = $NextFaceAnimation/OldFront
onready var old_face_front_num: Sprite = $NextFaceAnimation/OldFront/OldFrontNumber

onready var left_face_top: Sprite = $NextFaceAnimation/Left
onready var left_face_top_num: Sprite = $NextFaceAnimation/Left/Number

onready var right_face_top: Sprite = $NextFaceAnimation/Right
onready var right_face_top_num: Sprite = $NextFaceAnimation/Right/Number

onready var front_face_top: Sprite = $NextFaceAnimation/Bottom
onready var front_face_top_num: Sprite = $NextFaceAnimation/Bottom/Number

onready var behind_face_top: Sprite = $NextFaceAnimation/Top
onready var behind_face_top_num: Sprite = $NextFaceAnimation/Top/Number

onready var anim_player: AnimationPlayer = $AnimationPlayer

func move_dice(direction, number: int, front_number: int = 0) -> void:
	reset_animation()
	_set_current_face_as_old()
	_set_new_face_with_direction(direction, number, front_number)
	_hide_current_face()
	_update_current_face(number, front_number)
	_play_transition_animation(direction)


func reset_animation():
	anim_player.play("RESET")

func move_anim():
	#anim_player.play("move")
	pass


func _ready():
	_init_dice(top_num, front_num)


func _init_dice(top_number : int, front_number : int) -> void:
	_update_current_face(top_number, front_number)


func _update_current_face(top_number: int, front_number: int = 0) -> void:
	curr_face_top.frame = top_number - 1
	curr_face_top_num.frame = top_number - 1
	
	if front_number >= 1 && front_number <= 6:
		curr_face_front.frame = front_number - 1
		curr_face_front_num.frame = front_number - 1

func _set_new_face_with_direction(direction, number: int, front_number: int = 0):
	var face_node
	var face_node_num
	match direction:
		Constants.RIGHT:
			face_node = left_face_top
			face_node_num = left_face_top_num
		Constants.LEFT:
			face_node = right_face_top
			face_node_num = right_face_top_num
		Constants.BEHIND:
			face_node = front_face_top
			face_node_num = front_face_top_num
		Constants.FRONT:
			face_node = behind_face_top
			face_node_num = behind_face_top_num

	_set_new_face(face_node, face_node_num, number, front_number);


func _set_new_face(face_node, face_node_num, top_number: int, _front_number: int = 0):
	face_node.frame = top_number - 1
	face_node_num.frame = top_number - 1


func _hide_current_face():
	curr_face.visible = false


func _set_current_face_as_old() -> void:
	old_face_top.frame = curr_face_top.frame + 6
	old_face_top_num.frame = curr_face_top_num.frame
	old_face_front.frame = curr_face_front.frame
	old_face_front_num.frame = curr_face_front_num.frame


func _play_transition_animation(direction):
	match direction:
		Constants.RIGHT:
			anim_player.play("to_right")
		Constants.LEFT:
			anim_player.play("to_left")
		# troquei pq tava invertido vvvv
		Constants.BEHIND:
			anim_player.play("to_front")
		Constants.FRONT:
			anim_player.play("to_behind")

func _on_Button_pressed():
	move_dice(Constants.FRONT, 1)

