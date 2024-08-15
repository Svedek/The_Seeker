extends BaseState
class_name DionState


# Universal States
@onready var intermission_state = $"../IntermissionState"
@onready var idle_state = $"../IdleState"

var ai_controller: DionStageAIController :
	get:
		return character.dion_stage_ai_controller
var character_moving: bool = false
var next_action: DionStageAI.ACTION = -1


func process(delta:float) -> BaseState:
	match next_action:
		DionStageAI.ACTION.Intermission:
			return intermission_state
		DionStageAI.ACTION.Idle:
			return idle_state
	return super.process(delta)


func player_pos() -> Vector2:
	return Player.Instance.global_position


func player_dir() -> Vector2:
	return (Player.Instance.global_position - character.global_position).normalized()


func intermission_interrupt():
	next_action = DionStageAI.ACTION.Intermission


func damage_interrupt():
	pass  # called when damaged -> for use to dodge attacks or something


func exit():
	next_action = -1
	if character_moving:
		cancel_move()
	return super.exit()


func move_near_player(acceptable_distance: float):
	if character_moving:
		cancel_move()
	connect(character.move_complete, on_character_move_complete)
	character.move_near_player(acceptable_distance)
	character_moving = true


func move_to(loc: Vector2):
	if character_moving:
		cancel_move()
	connect(character.move_complete, on_character_move_complete)
	character.move_to(loc)
	character_moving = true


func dodge_to(loc: Vector2):
	if character_moving:
		cancel_move()
	connect(character.move_complete, on_character_move_complete)
	character.dodge_to(loc)
	character_moving = true


func cancel_move():
	disconnect(character.move_complete, on_character_move_complete)
	character.cancel_move()
	character_moving = false


func on_character_move_complete():
	disconnect(character.move_complete, on_character_move_complete)
	character_moving = false
