extends Node
class_name DionStageAI


enum MOVEMENT {Walk, Run, Scramble, Dodge}
enum ACTION {None=0, Intermission, Idle, Strike, Fan, Charge, ChannelOrb, TossOrb}
enum ORB_PATTERN {Bounce, Orbit}



@export var health: int
@export var movement: MOVEMENT
@export var global_cooldown: float = 1.0  # Idle time between moves
@export var leisure: float = 1.0  # Goofiness coefficient

@export_group("Intermission")
@export var intermission_stage_break: bool = false

@export_group("Idle")
@export var idle_something: bool = false

@export_group("Strike")
@export_range(0.0, 1.0) var stirke_probability: float = 0.0
@export_subgroup("Info")
@export_range(1, 8) var strike_count: int = 1
@export var stirke_dodges: int = 0

@export_group("Fan")
@export_range(0.0, 1.0) var fan_probability: float = 0.0
@export_subgroup("Info")
@export_range(1, 32) var fan_projectile_count: int = 1
@export_range(1, 4) var fan_waves: int = 1
@export var fan_wave_delay: float = 1.0

@export_group("Charge")
@export_range(0.0, 1.0) var charge_probability: float = 0.0
@export_subgroup("Info")
@export var charge_initial_time: float = 1.0
@export var charge_vertex_time: float = 0.25
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


func get_next_move(exclude = ACTION.None) -> ACTION:  # TODO make this exclude (last used move) if needed
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
		return ACTION.ChannelOrb
	roll -= channel_orb_probability
	
	if roll <= toss_orb_probability:
		return ACTION.TossOrb
	roll -= toss_orb_probability
	
	return -1
