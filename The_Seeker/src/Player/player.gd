extends CharacterBody2D


const SPEED = 300.0
const DASH_MOD = 1.5


func _physics_process(delta):
	_handle_input()
	
	move_and_slide()

func _handle_input():
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		pass
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var axis = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
