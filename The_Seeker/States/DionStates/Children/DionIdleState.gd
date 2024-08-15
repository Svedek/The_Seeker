extends DionState


@onready var strike_state = $"../StrikeState"
@onready var fan_state = $"../FanState"
@onready var charge_state = $"../ChargeState"
@onready var channel_orb_state = $"../ChannelOrbState"
@onready var toss_orb_state = $"../TossOrbState"

var action_timer: Timer
# TODO logic to decide what to do

func enter(direction: Vector2):
	action_timer = create_timer(prepare_next_action, ai_controller.active_stage.global_cooldown)
	super.enter(direction)


# Reset active_timer
func exit() -> Vector2:
	if action_timer:
		action_timer.stop()
		action_timer.queue_free()
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
		DionStageAI.ACTION.Channel_orb:
			return channel_orb_state
		DionStageAI.ACTION.Toss_orb:
			return toss_orb_state
	return super.process(delta)


func prepare_next_action():
		next_action = ai_controller.active_stage.get_next_move()

