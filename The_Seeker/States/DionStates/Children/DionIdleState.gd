extends DionState


@onready var strike_state = $"../StrikeState"
@onready var fan_state = $"../FanState"
@onready var charge_state = $"../ChargeState"
@onready var channel_orb_state = $"../ChannelOrbState"
@onready var toss_orb_state = $"../TossOrbState"

var active_timer: Timer
var next_action: DionStageAI.ACTION = -1
# TODO logic to decide what to do

func enter(direction: Vector2):
	active_timer = create_timer(prepare_next_action, character.dion_stage_ai_controller.active_stage.global_cooldown)
	super.enter(direction)


func exit() -> Vector2:
	# Reset active_timer, next_move
	
	next_action = -1
	return super.exit()


#TODO override update -> if next_action != -1 --> swap state


func prepare_next_action():
	pass  # TODO set next_action

