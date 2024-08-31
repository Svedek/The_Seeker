class_name BaseState
extends Node

@export var animation_name: String

var character: CharacterBody2D
var available: bool = true
var dir: Vector2

func enter(direction: Vector2):
	dir = direction
	character.set_blend_position(animation_name, dir)
	character.play_animation(animation_name)
	
func exit() -> Vector2:
	return dir

func input(_event):
	pass
	
func process(_delta:float) -> BaseState:
	return null
	
func physics_process(_delta: float) -> BaseState:
	return null


func create_timer(function, time) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(time)
	timer.one_shot = true
	if function:
		timer.connect("timeout", function) 
	return timer
