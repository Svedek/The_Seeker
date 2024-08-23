extends Node2D


signal start_reached
signal options_reached
signal options_left
signal extra_reached
signal extra_left
signal exit_reached

@onready var _animation_tree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")


func animate_play():
	_animation_playback.travel("play")


func animate_options_enter():
	_animation_playback.travel("options_enter")


func animate_options_exit():
	_animation_playback.travel("options_exit")


func animate_extra():
	_animation_playback.travel("extra_enter")


func animate_extra_exit():
	_animation_playback.travel("extra_exit")


func animate_exit():
	_animation_playback.travel("exit")
	
