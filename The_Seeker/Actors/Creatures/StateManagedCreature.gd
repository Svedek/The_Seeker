class_name StateManagedCreature
extends CharacterBody2D

@onready var _sprite : Sprite2D = $Sprite
@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")
@onready var _state_manager : StateManager = $StateManager

