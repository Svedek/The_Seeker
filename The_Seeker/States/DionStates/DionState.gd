extends BaseState
class_name DionState


@onready var ai_controller: DionStageAIController = character.dion_stage_ai_controller

# Universal States
@onready var intermission_state = $"../IntermissionState"
@onready var idle_state = $"../IdleState"


func player_pos() -> Vector2:
	return Player.Instance.global_position


func player_dir() -> Vector2: # Dir or ref?
	return (Player.Instance.global_position - character.global_position).normalized()


func intermission_interrupt():
	pass # TODO dodge to center and -> intermission


func damage_interrupt():
	pass
