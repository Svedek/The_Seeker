extends BaseState
class_name DionState

# Universal States
@onready var intermission_state = $"../IntermissionState"
@onready var idle_state = $"../IdleState"



func player_pos() -> Vector2: # Dir or ref?
	return Player.Instance.position


func intermission_interrupt():
	pass # TODO dodge to center and -> intermission


func damage_interrupt():
	pass
