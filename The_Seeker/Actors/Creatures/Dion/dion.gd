extends StateManagedCreature

signal initiate_boss(id: int) # ???
signal update_boss_health(health: int)

@onready var stats : CreatureStats = $Stats
#@onready var _weapon_pivot : Marker2D = $WeaponPivot
#@onready var _firepoint : Marker2D = $WeaponPivot/Firepoint                              

var _ghost_scene = preload("res://Actors/Effects/Ghost/ghost.tscn")
var stage = 0


func play_animation(animation: String):
	_animation_playback.travel(animation)
	
func set_blend_position(animation: String, blend_position: Vector2):
	_animation_tree["parameters/" + animation + "/blend_position"] = blend_position

#func set_weapon_pivot_dir(dir:Vector2):
#	_weapon_pivot.rotation = dir.angle()

func instance_ghost():
	var ghost: Sprite2D = _ghost_scene.instantiate()
	get_parent().add_child(ghost)
	ghost.global_position = _sprite.global_position
	ghost.texture = _sprite.texture
	ghost.hframes = _sprite.hframes
	ghost.vframes = _sprite.vframes
	ghost.frame = _sprite.frame

func _on_hurtbox_damaged(damage):
	pass # Replace with function body.
