extends Area2D

signal pierced
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const ORB_LAYER = 1 << 8

var speed = 128
var target = Vector2.ZERO
var movement_func = _move_dir

var _velocity = Vector2.ZERO


func _ready():
	GameManager.new_stage.connect(activate)


func physics_process(delta): # Called from orb_controller
	if !$Hitbox.monitoring:
		return
	
	movement_func.call(delta)
	
	position += _velocity


func activate():
	collision_layer = ORB_LAYER
	$Hitbox.monitoring = true
	animation_player.play("active")


func orb_pierced():
	collision_layer = 0
	$Hitbox.monitoring = false
	animation_player.play("deactive")
	GameManager.orb_shot()


func set_move_dir():
	movement_func = _move_dir


func set_move_pos():
	movement_func = _move_pos


func _move_dir(delta):
	_velocity += target * speed * delta
	_velocity = _velocity.limit_length(speed * delta)


func _move_pos(delta):
	var dir = (target - global_position).normalized()
	_velocity += dir * speed * delta
	_velocity = _velocity.limit_length(speed * delta)


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

