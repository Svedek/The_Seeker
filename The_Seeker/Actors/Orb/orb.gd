extends Area2D

signal pierced

@onready var animation_player: AnimationPlayer = $AnimationPlayer
const ORB_LAYER = 1 << 8

var speed = 128
var target = Vector2.ZERO
var movement_func = _move_dir

var _velocity = Vector2.ZERO


func physics_process(delta): # Called from orb_controller
	movement_func.call(delta)


func activate():
	collision_layer = ORB_LAYER
	$Hitbox.monitoring = true
	animation_player.play("active")


func orb_pierced():
	collision_layer = 0
	$Hitbox.monitoring = false
	animation_player.play("deactive")
	pierced.emit()


func set_move_dir():
	movement_func = _move_dir


func set_move_pos():
	movement_func = _move_pos


func set_move_return():
	movement_func = _move_return


func _move_dir(delta):
	if !$Hitbox.monitoring:
		return
	_velocity += target * speed * delta
	_velocity = _velocity.limit_length(speed * delta)
	position += _velocity


func _move_pos(delta):
	if !$Hitbox.monitoring:
		return
	var dir = (target - global_position).normalized()
	_velocity += dir * speed * delta
	_velocity = _velocity.limit_length(speed * delta)
	if (target - global_position).length() < _velocity.length():
		_velocity = target - global_position
	position += _velocity


func _move_return(delta):
	var dir = (target - global_position).normalized()
	_velocity += dir * speed * delta
	_velocity = _velocity.limit_length(speed * delta)
	if (target - global_position).length() < _velocity.length():
		_velocity = target - global_position
	position += _velocity


func _on_right_bumper_body_entered(body):
	if _velocity.x > 0:
		_velocity.x *= -1
		target.x *= -1


func _on_top_bumper_body_entered(body):
	if _velocity.y < 0:
		_velocity.y *= -1
		target.y *= -1


func _on_left_bumper_body_entered(body):
	if _velocity.x < 0:
		_velocity.x *= -1
		target.x *= -1


func _on_bot_bumper_body_entered(body):
	if _velocity.y > 0:
		_velocity.y *= -1
		target.y *= -1

