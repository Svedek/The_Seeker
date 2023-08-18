class_name Player
extends CharacterBody2D

signal update_arrows(count: int)
# signal update_stamina(value: float)

@onready var stats : CreatureStats = $Stats
@onready var _sprite : Sprite2D = $Sprite
@onready var _weapon_pivot : Marker2D = $WeaponPivot
@onready var _firepoint : Marker2D = $WeaponPivot/Firepoint
@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")
@onready var _state_manager : StateManager = $StateManager

var _ghost_scene = preload("res://Misc/ghost.tscn")
var _arrows:int = 3 :
	set (count):
		_arrows = count
		emit_signal("update_arrows", _arrows)
	

func _ready():
	_animation_tree.active = true
	_state_manager.init(self)

func _process(delta):
	_state_manager.process(delta)
	
func _physics_process(delta):
	_state_manager.physics_process(delta)

func _unhandled_input(event):
	_state_manager.input(event)

func _on_hurtbox_damaged(damage):
	print("player took " + str(damage) + " damage")
	
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
	
func gain_arrow():
	_arrows += 1

@onready var texture_progress_bar = $TextureProgressBar
@onready var texture_progress_bar_2 = $TextureProgressBar2
@onready var texture_progress_bar_3 = $TextureProgressBar3
func update_stamina(value:float):
	texture_progress_bar.value = value*100
	texture_progress_bar_2.value = (value-1)*100
	texture_progress_bar_3.value = (value-2)*100
