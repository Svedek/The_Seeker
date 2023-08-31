extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		if event.is_class("InputEventMouseButton"):
			position = get_global_mouse_position()

func _follow_player():
	pass

func update_camera(pos:Vector2, limits:Vector4):
	position = pos
	limit_left = limits.w
	limit_top = limits.x
	limit_right = limits.y
	limit_bottom = limits.z
