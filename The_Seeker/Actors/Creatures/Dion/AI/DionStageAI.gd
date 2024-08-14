extends Node
class_name DionStageAI


enum SPEED {Walk, Run, Scramble}
enum ACTION {Strike, Fan, Charge, Channel_orb, Toss_orb}
enum ORB_PATTERN {Bounce, Orbit}



@export var speed2: SPEED
@export var global_cooldown: float = 1.0  # Time between moves

@export_group("Strike")
@export_range(0.0, 1.0) var stirke_probability: float = 0.0
@export_subgroup("Info")
@export_range(1, 8) var strike_count: int = 1
@export var stirke_dodges: int = 0

@export_group("Fan")
@export_range(0.0, 1.0) var fan_probability: float = 0.0
@export_subgroup("Info")
@export_range(1, 32) var fan_count: int = 1

@export_group("Charge")
@export_range(0.0, 1.0) var charge_probability: float = 0.0
@export_subgroup("Info")
@export_range(1, 16) var charge_count: int = 1

@export_group("Channel Orb")
@export_range(0.0, 1.0) var channel_orb_probability: float = 0.0
@export_subgroup("Info")
@export var channel_orb_pattern: ORB_PATTERN = -1

@export_group("Toss Orb")
@export_range(0.0, 1.0) var toss_orb_probability: float = 0.0
@export_subgroup("Info")
@export_range(1, 9) var toss_orb_count: int = 1


@onready var total_probability = stirke_probability + fan_probability + charge_probability + channel_orb_probability + toss_orb_probability


func get_next_move() -> ACTION:
	var roll = randf_range(0, total_probability)
	
	if roll <= stirke_probability:
		return ACTION.Strike
	roll -= stirke_probability
	
	if roll <= fan_probability:
		return ACTION.Fan
	roll -= fan_probability
	
	if roll <= charge_probability:
		return ACTION.Charge
	roll -= charge_probability
	
	if roll <= channel_orb_probability:
		return ACTION.Channel_orb
	roll -= channel_orb_probability
	
	if roll <= toss_orb_probability:
		return ACTION.Toss_orb
	roll -= toss_orb_probability
	
	return -1
