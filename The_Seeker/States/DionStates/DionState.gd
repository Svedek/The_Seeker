extends BaseState
class_name DionState


# Universal States
@onready var intermission_state = $"../IntermissionState"
@onready var idle_state = $"../IdleState"

var ai_controller: DionStageAIController :
	get:
		return character.dion_stage_ai_controller
var next_action: DionStageAI.ACTION = DionStageAI.ACTION.None
var orb_controller: OrbController :
	get:
		return character.orb_controller


func exit():
	next_action = DionStageAI.ACTION.None
	if character_moving:
		cancel_move()
	return super.exit()


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


func attempt_damage() -> bool:  # called when damaged -- for use to dodge attacks or something
	if 0 < orb_controller.active_orbs:
		return false
	return true  # damage goes through






var character_moving: bool = false
var move_target: Vector2
var move_func: Callable
var move_animation: String
var move_acceptable_distance: float
func physics_process(delta:float) -> BaseState:
	if character_moving:
		move_func.call(delta)
	return null
	# GET DIR, USE DIR to make move vect, know when to end
	# Start animation in initial call, 


func get_move_animation(dodge: bool) -> String:
	ai_controller.active_stage.leisure  # TODO use leisure to decide animation
	if dodge:
		return "Dodge"
	else:  # TODO returns name of animation for SPEED
		return "Move"


func move_near_player(acceptable_distance: float):
	move_acceptable_distance = acceptable_distance
	move_func = move_near_player_process
	character_moving = true
	move_animation = get_move_animation(false)
	character.play_animation(move_animation)


func move_near_player_process(delta: float):
	var to_player = player_pos() - character.position
	
	# Check if target reached
	if to_player.length() <= move_acceptable_distance:
		end_move()
		return
	
	# Calculate move_vect and set animation blend position
	var move_vect = to_player.normalized()
	character.set_blend_position(move_animation, move_vect)
	move_vect *= delta * DionStageAIController.move_speed_dict[ai_controller.active_stage.speed]
	
	# Clamp to not pass target
	move_vect = move_vect.limit_length(to_player.length())
	
	# Do move
	character.position += move_vect


func move_to(loc: Vector2):
	move_target = loc
	character_moving = true
	move_func = move_to_process
	move_animation = get_move_animation(false)
	character.play_animation(move_animation)


func move_to_process(delta: float):
	var to_target = move_target - character.position
	
	# Calculate move_vect and set animation blend position
	var move_vect = to_target.normalized()
	character.set_blend_position(move_animation, move_vect)
	move_vect *= delta * DionStageAIController.move_speed_dict[ai_controller.active_stage.speed]
	
	# Clamp to not pass target (and also test if destination reached)
	if to_target.length() <= move_vect.length():
		move_vect = to_target
		end_move()  # Still changes character.position after this to actually reach destination
	
	# Do move
	character.position += move_vect


func dodge_to(loc: Vector2):
	move_target = loc
	character_moving = true
	move_func = dodge_to_process
	move_animation = get_move_animation(true)
	character.play_animation(move_animation)


func dodge_to_process(delta: float):
	var to_target = move_target - character.position
	
	# Calculate move_vect and set animation blend position
	var move_vect = to_target.normalized()
	character.set_blend_position(move_animation, move_vect)
	move_vect *= delta * DionStageAIController.move_speed_dict["Dodge"]
	
	# Clamp to not pass target (and also test if destination reached)
	if to_target.length() <= move_vect.length():
		move_vect = to_target
		end_move()  # Still changes character.position after this to actually reach destination
	
	# Do move
	character.position += move_vect


func end_move():
	character_moving = false
	on_end_move()
	
	
func on_end_move():  # Overridable, called when move reached destination
	pass


func cancel_move():  # Maybe unnessesary
	character_moving = false
