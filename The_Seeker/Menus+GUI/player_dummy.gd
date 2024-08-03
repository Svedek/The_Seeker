extends Node2D


@onready var _animation_tree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")

func animate_idle(dir):
	_animation_tree["parameters/Idle/blend_position"] = dir
	_animation_playback.travel("Idle")

func animate_run(dir):
	_animation_tree["parameters/Run/blend_position"] = dir
	_animation_playback.travel("Run")

