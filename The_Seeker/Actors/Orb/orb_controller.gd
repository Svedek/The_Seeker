extends Node

const ORB = preload("res://Actors/Orb/orb.tscn")
var orbs = 0
var move_func

var _radius = -1.0
var _time = 0.0

func _input(event): # TODO TESTING
	if Input.is_physical_key_pressed(KEY_6):
		spawn_orb(Vector2.ZERO)
	if Input.is_physical_key_pressed(KEY_7):
		switch_to_spiral()
	if Input.is_physical_key_pressed(KEY_8):
		switch_to_bounce()


func _physics_process(delta):
	if move_func:
		move_func.call()
	for orb in get_children():
		orb.physics_process(delta)
	_time += delta


func spawn_orb(pos: Vector2):
	var child = ORB.instantiate()
	add_child(child)
	child.global_position = pos
	orbs += 1


func switch_to_spiral():
	_radius = 32 * (orbs/3)
	_time = 0.0
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
