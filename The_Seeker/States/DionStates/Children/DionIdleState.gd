extends DionState


@onready var move_state = $"../MoveState"
@onready var strike_state = $"../StrikeState"
@onready var fan_state = $"../FanState"
@onready var charge_state = $"../ChargeState"
@onready var channel_orb_state = $"../ChannelOrbState"
@onready var toss_orb_state = $"../TossOrbState"

@onready var action_timer: Timer = create_timer(prepare_next_action, 1)  #  Action timer's time is set when entering IdleState


func enter(direction: Vector2):
	action_timer.start(ai_controller.active_stage.global_cooldown)
	super.enter(direction)


# Reset active_timer
func exit() -> Vector2:
	if action_timer:
		action_timer.stop()
	return super.exit()


func process(delta:float) -> BaseState:
	dir = player_dir()
	character.set_blend_position(animation_name, dir)
	
	match next_action:
		DionStageAI.ACTION.Strike:
			return strike_state
		DionStageAI.ACTION.Fan:
			return fan_state
		DionStageAI.ACTION.Charge:
			return charge_state
		DionStageAI.ACTION.ChannelOrb:
			return channel_orb_state
		DionStageAI.ACTION.TossOrb:
			return toss_orb_state
	return super.process(delta)


func prepare_next_action():
	next_action = ai_controller.active_stage.get_next_move()
	print("Go off Dion: " + str(ai_controller.ACTION_NAME_DICT[next_action]))






func input(_event):  # TODO TESTING
	if Input.is_physical_key_pressed(KEY_V):
		print(character.get_global_mouse_position())
		move_to(character.get_global_mouse_position())

