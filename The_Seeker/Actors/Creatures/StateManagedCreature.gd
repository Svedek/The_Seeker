class_name StateManagedCreature
extends CharacterBody2D

@onready var _sprite : Sprite2D = $Sprite
@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")
@onready var _state_manager : StateManager = $StateManager


func _ready():
	_animation_tree.active = true
	_state_manager.init(self)

func _process(delta):
	_state_manager.process(delta)
	
func _physics_process(delta):
	_state_manager.physics_process(delta)

func _unhandled_input(event):
	_state_manager.input(event)
	
func set_blend_position(animation: String, blend_position: Vector2):
	_animation_tree["parameters/" + animation + "/blend_position"] = blend_position
