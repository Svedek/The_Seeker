extends Node
class_name OrbController

# Arrows are also spawned here on new stage, make of that what you will...

const ORB = preload("res://Actors/Orb/orb.tscn")
const ARROW_COLLECTABLE = preload("res://Actors/Collectable/Arrow/arrow_collectable.tscn")
const CENTER = Vector2()
var orbs = 0
var active_orbs: int:
	set(value):
		GameManager.update_active_orbs.emit(value)
		active_orbs = value
var move_func

var _radius = -1.0
var _time = 0.0
var _time_scale = 1.0

func _input(event): # TODO TESTING
	if Input.is_physical_key_pressed(KEY_4):
		spawn_orb(Vector2.ZERO)
	if Input.is_physical_key_pressed(KEY_5):
		switch_to_return()
	if Input.is_physical_key_pressed(KEY_6):
		switch_to_center()
	if Input.is_physical_key_pressed(KEY_7):
		switch_to_spiral()
	if Input.is_physical_key_pressed(KEY_8):
		switch_to_bounce()


func _ready():
	GameManager.update_active_orbs.emit(active_orbs)  # Update active orb bar
	GameManager.new_stage.connect(on_new_stage)


func _physics_process(delta):
	if move_func:
		move_func.call()
	for orb in get_children():
		orb.physics_process(delta)
	_time += delta * _time_scale


func spawn_orb(pos: Vector2):
	var child = ORB.instantiate()
	add_child(child)
	child.global_position = pos
	orbs += 1
	child.pierced.connect(on_orb_pierced)


func spawn_arrow(pos: Vector2):
	var child = ARROW_COLLECTABLE.instantiate()
	get_tree().root.add_child(child)
	child.global_position = pos


func on_new_stage():
	spawn_orb(Vector2.ZERO)
	for orb in get_children():
		orb.activate()
	active_orbs = orbs
	spawn_arrow(Vector2.ZERO)


func on_orb_pierced():
	active_orbs -= 1


func switch_to_return():
	_radius = 16
	_time = 0.0
	_time_scale = 1.00
	move_func = move_spiral
	for orb in get_children():
		orb.set_move_return()


func switch_to_center():
	_radius = 16
	_time = 0.0
	_time_scale = 1.00
	move_func = move_spiral
	for orb in get_children():
		orb.set_move_pos()


func switch_to_spiral():
	_radius = 24 + 8 * orbs
	_time = 0.0
	_time_scale = 1.0
	move_func = move_spiral
	for orb in get_children():
		orb.set_move_pos()


func switch_to_bounce():
	for orb in get_children():
		orb.set_move_dir()
		orb.target = Vector2(randf()*2-1, randf()*2-1).normalized()
	move_func = move_bounce


func move_spiral():
	var children = get_children()
	for i in range(children.size()):
		var theta = 2.0/orbs*PI*i + 2*PI*_time/4
		children[i].target = Vector2(cos(theta), sin(theta)) * _radius
	

func move_bounce():
	pass
