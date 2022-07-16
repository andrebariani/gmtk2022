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
	$ComboButton.visible = debug


func set_next_combo_face(face_number):
	combo.set_next_combo_face(faces[face_number-1])


func trigger_combo():
	combo.trigger_combo()


func set_current_faces(main, behind, front, left, right, down):
	diceFaces.set_current_faces(main, behind, front, left, right, down)


func set_health(health):
	healthbar.set_health(health)


func _on_ComboButton_button_up():
	set_next_combo_face(5)

func _on_FinishButton_button_up():
	trigger_combo()
