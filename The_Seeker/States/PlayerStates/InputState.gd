extends BaseState
class_name InputState

func get_axis() -> Vector2:
	var axis: Vector2 = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	return axis.normalized()
