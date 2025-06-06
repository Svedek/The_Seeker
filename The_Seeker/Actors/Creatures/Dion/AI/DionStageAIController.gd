extends Node
class_name DionStageAIController


signal all_stages_completed


@onready var stats = $"../Stats"

var active_stage: DionStageAI
var active_stage_number: int = 0
@onready var final_stage_number: int = get_child_count()
const FILE_PREFIX: String = "Stage"
const MOVE_SPEED_DICT: Dictionary = {DionStageAI.MOVEMENT.Walk: 160.0, DionStageAI.MOVEMENT.Run: 240.0, DionStageAI.MOVEMENT.Scramble: 320.0, DionStageAI.MOVEMENT.Dodge: 480.0}
const MOVE_NAME_DICT: Dictionary = {DionStageAI.MOVEMENT.Walk: "Walk", DionStageAI.MOVEMENT.Run: "Run", DionStageAI.MOVEMENT.Scramble: "Scramble", DionStageAI.MOVEMENT.Dodge: "Dodge"}
const ACTION_NAME_DICT: Dictionary = {DionStageAI.ACTION.None: "None", DionStageAI.ACTION.Intermission: "Intermission", DionStageAI.ACTION.Idle: "Idle", DionStageAI.ACTION.Strike: "Strike", DionStageAI.ACTION.Fan: "Fan", DionStageAI.ACTION.Charge: "Charge", DionStageAI.ACTION.ChannelOrb: "ChannelOrb", DionStageAI.ACTION.TossOrb: "TossOrb"}


# Override
func _ready():
	advance_active_stage()


func advance_active_stage():
	active_stage_number += 1
	print("Entering stage: " + str(active_stage_number))
	if active_stage_number <= final_stage_number:
		active_stage = get_node(FILE_PREFIX + str(active_stage_number))  # TODO maybe use the index of the child instead of name
		update_stats()
	else:
		all_stages_completed.emit()
		print("No stage, WIN!!!")


func update_stats():  # Also refills Dion's health
	stats.move_speed = MOVE_SPEED_DICT[active_stage.movement]
	stats._max_health = active_stage.health
	stats.health = stats._max_health
	GameManager.update_dion_health.emit(stats.health)
