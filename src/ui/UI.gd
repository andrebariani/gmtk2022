extends Control
class_name UI

export var debug = true
export(Array, Texture) var faces

onready var healthbar = $Healthbar
onready var combo = $Combo
onready var diceFaces = $DiceFaces

# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthButton.visible = debug
	$DiceButton.visible = debug


func set_next_combo_face(face_number):
	combo.texture = faces[face_number-1]


func set_current_faces(main, behind, front, left, right, down):
	diceFaces.set_current_faces(main, behind, front, left, right, down)


func set_health(health):
	healthbar.set_health(health)
