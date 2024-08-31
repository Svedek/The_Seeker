extends Node
class_name DionStageAIController


signal all_stages_completed


@onready var stats = $"../Stats"

var active_stage: DionStageAI
var active_stage_number: int = 0
@onready var final_stage_number: int = get_child_count()
const _file_prefix: String = "Stage"
const move_speed_dict: Dictionary = {DionStageAI.SPEED.Walk: 160.0, DionStageAI.SPEED.Run: 240.0, DionStageAI.SPEED.Scramble: 320.0, "Dodge": 480.0}


func _ready():
	advance_active_stage()


func advance_active_stage():
	active_stage_number += 1
	print("Entering stage: " + str(active_stage_number))
	if active_stage_number <= final_stage_number:
		active_stage = get_node(_file_prefix + str(active_stage_number))  # TODO maybe use the index of the child instead of name
		update_stats()
	else:
		all_stages_completed.emit()
		print("No stage, WIN!!!")


func update_stats():
	stats.move_speed = move_speed_dict[active_stage.speed]
	stats._max_health = active_stage.health
	stats.health = stats._max_health
	GameManager.update_dion_health.emit(stats.health)
