class_name Player
extends StateManagedCreature

signal player_death()
signal update_arrows(count: int)

@onready var stats : CreatureStats = $Stats
@onready var _weapon_pivot : Marker2D = $WeaponPivot
@onready var _firepoint : Marker2D = $WeaponPivot/Firepoint
@onready var stamina_node_1 = $StaminaNode1
@onready var stamina_node_2 = $StaminaNode2
@onready var stamina_node_3 = $StaminaNode3

static var Instance:Player

var _ghost_scene = preload("res://Actors/Effects/Ghost/ghost.tscn")
var _arrows:int = 0 :
	set (count):
		_arrows = count
		emit_signal("update_arrows", _arrows)
	

func _ready():
	super._ready()
	GameCamera.player = self
	Instance = self

func _on_hurtbox_damaged(damage): # IS THIS CORRECT?
	print("player took " + str(damage) + " damage")
	
func play_animation(animation: String):
	_animation_playback.travel(animation)

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

func update_stamina(value:float):
	stamina_node_1.value = value*100
	stamina_node_2.value = (value-1)*100
	stamina_node_3.value = (value-2)*100
