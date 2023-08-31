extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack",true):
		print("yes")
	pass

func _unhandled_input(event):
	print(event)
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT && event.is_echo():
		
	pass
