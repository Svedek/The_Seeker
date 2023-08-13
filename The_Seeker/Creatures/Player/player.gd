class_name Player
extends CharacterBody2D

var _ghost_scene = preload("res://Misc/ghost.tscn")

@onready var stats : CreatureStats = $Stats

@onready var _sprite : Sprite2D = $Sprite
@onready var _weapon_pivot : Marker2D = $WeaponPivot
@onready var _firepoint : Marker2D = $WeaponPivot/Firepoint
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

func play_animation(animation: String):
	_animation_playback.travel(animation)
	
func set_blend_position(animation: String, blend_position: Vector2):
	_animation_tree["parameters/" + animation + "/blend_position"] = blend_position

func set_weapon_pivot_dir(dir:Vector2):
	_weapon_pivot.rotation = dir.angle()

func instance_ghost():
	var ghost: Sprite2D = _ghost_scene.instantiate()
	get_parent().add_child(ghost)
	ghost.global_position = _sprite.global_position
	ghost.texture = _sprite.texture
	ghost.hframes = _sprite.hframes
	ghost.vframes = _sprite.vframes
	ghost.frame = _sprite.frame

func _on_hurtbox_damaged(damage):
	print("player took " + str(damage) + " damage")
