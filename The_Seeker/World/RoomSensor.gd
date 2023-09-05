extends Area2D

@export var zoom: Vector2 = Vector2.ONE * 2
var limits: Vector4


func _ready():
	var col_shape: CollisionShape2D = $CollisionShape2D
	var shape_size: Vector2 = col_shape.shape.size / 2
	var min_val : float = ProjectSettings.get_setting("display/window/size/viewport_width") / zoom.x / 2
	limits = Vector4( # Left, Top, Right, Bottom
		col_shape.global_position.x-max(shape_size.x+32, min_val),
		col_shape.global_position.y-max(shape_size.y+32, min_val),
		col_shape.global_position.x+max(shape_size.x+32, min_val),
		col_shape.global_position.y+max(shape_size.y+32, min_val))
	
	

func _on_body_entered(body):
	GameCamera.update_camera(zoom, limits)

