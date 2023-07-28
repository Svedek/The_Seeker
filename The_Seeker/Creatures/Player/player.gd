class_name Player
extends CharacterBody2D

var _ghost_scene = preload("res://Misc/ghost.tscn")

const MOVE_SPEED = 160.0

@onready var _sprite = $Sprite
@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")

@onready var state_manager : StateManager = $StateManager


#func _create_timer (function, time) -> Timer:
#	var timer = Timer.new()
#	add_child(timer)
#	timer.set_wait_time(time)
#	timer.one_shot = true
#	timer.connect("timeout", function) 
#	return timer


func _ready():
	_animation_tree.active = true
	state_manager.init(self)

func _process(delta):
	state_manager.process(delta)
	
func _physics_process(delta):
	state_manager.physics_process(delta)

func _unhandled_input(event):
	state_manager.input(event)


func instance_ghost():
	var ghost: Sprite2D = _ghost_scene.instantiate()
	get_parent().add_child(ghost)
	ghost.global_position = _sprite.global_position
	ghost.texture = _sprite.texture
	ghost.hframes = _sprite.hframes
	ghost.vframes = _sprite.vframes
	ghost.frame = _sprite.frame

func play_animation(animation: String):
	_animation_playback.travel(animation)
	
func set_blend_position(animation: String, blend_position: Vector2):
	_animation_tree["parameters/" + animation + "/blend_position"] = blend_position
