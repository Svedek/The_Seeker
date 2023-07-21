class_name BaseState
extends Node

@export var animation_name: String

var player: Player

func enter():
	player.animations.play(animation_name)
	
func exit():
	pass

func input(event):
	pass
	
func process(delta:float) -> BaseState:
	return null
	
func physics_process(delta: float) -> BaseState:
	return null

	
