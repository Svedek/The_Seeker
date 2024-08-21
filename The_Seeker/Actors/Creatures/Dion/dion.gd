extends StateManagedCreature

signal initiate_boss(id: int) # ???
signal update_boss_health(health: int)
signal move_complete


@export var speeds: Array

@onready var stats = $Stats
@onready var dion_stage_ai_controller = $DionStageAIController
@onready var orb_controller = $OrbController


var _ghost_scene = preload("res://Actors/Effects/Ghost/ghost.tscn")
var stage: int = 0


func movement_state() -> int:
	return stage/3


func play_animation(animation: String):
	_animation_playback.travel(animation)


func set_blend_position(animation: String, blend_position: Vector2):
	_animation_tree["parameters/" + animation + "/blend_position"] = blend_position


func move_near_player(acceptable_distance: float):
	pass


func move_to(loc: Vector2):
	pass


func dodge_to(loc: Vector2):
	pass


func cancel_move():
	pass


func instance_ghost():
	var ghost: Sprite2D = _ghost_scene.instantiate()
	get_parent().add_child(ghost)
	ghost.global_position = _sprite.global_position
	ghost.texture = _sprite.texture
	ghost.hframes = _sprite.hframes
	ghost.vframes = _sprite.vframes
	ghost.frame = _sprite.frame


func _on_hurtbox_damaged(damage):
	if _state_manager.current_state.attempt_damage():
		stats.health -= damage
		GameManager.update_dion_health.emit(stats.health)


func _on_stats_death():
	pass # TODO intermission interrupt
