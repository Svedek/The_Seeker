extends BaseState
class_name MovementState


func physics_process(delta) -> BaseState:
	player.move_and_slide()
	return null

func get_axis() -> Vector2:
	var axis: Vector2 = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	return axis.normalized()
