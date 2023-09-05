extends Camera2D

enum CameraState {
	idle,
	follow_player
}
var _state : CameraState = CameraState.idle
var player:Player


func _process(delta):
	match(_state):
		CameraState.idle:
			pass
		CameraState.follow_player:
			_follow_player()

#func _unhandled_input(event: InputEvent):
#	if event.is_action_pressed("attack"):
#		if event.is_class("InputEventMouseButton"):
#			position = get_global_mouse_position()
#			_state = CameraState.idle
#		else:
#			_state = CameraState.follow_player

func update_camera(new_zoom:Vector2, limits:Vector4):
	zoom = new_zoom
	limit_left = limits.x
	limit_top = limits.y
	limit_right = limits.z
	limit_bottom = limits.w
	_state = CameraState.follow_player


func _follow_player():
	if player == null:
		_state = CameraState.idle
		return
	position = player.position
