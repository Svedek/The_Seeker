extends Node
class_name DionStageAIController


@onready var stats = $"../Stats"

var active_stage: DionStageAI
const _file_prefix: String = "Stage"
const move_speed_dict: Dictionary = {DionStageAI.SPEED.Walk: 160.0, DionStageAI.SPEED.Run: 240.0, DionStageAI.SPEED.Scramble: 320.0}

func _ready():
	update_active_stage(1)


func update_active_stage(next_stage: int):
	active_stage = get_node(_file_prefix + str(next_stage))
	update_stats()


func update_stats():
	stats.move_speed = move_speed_dict[active_stage.speed]
	stats._max_health = active_stage.health
	stats.health = stats._max_health
	GameManager.update_dion_health.emit(stats.health)
