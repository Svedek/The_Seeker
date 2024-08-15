extends Node
class_name DionStageAIController


var active_stage: DionStageAI
const _file_prefix: String = "Stage"


func _ready():
	update_active_stage(1)


func update_active_stage(next_stage: int):
	active_stage = get_node(_file_prefix + str(next_stage))
