extends EnemyConstantMoveState

# Goes to Idle, Dash, Attack, Aim

@export_category("State Transitions")
@export var idle_node: NodePath
@export var dash_node: NodePath
@export var attack_node: NodePath
@export var aim_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var attack_state: BaseState = get_node(attack_node)
@onready var aim_state: BaseState = get_node(aim_node)

func input(event):
	if event.is_action_pressed("dash") && dash_state.available:
		dir = get_axis()
		return dash_state
	elif event.is_action_pressed("attack") && attack_state.available:
		attack_state.input(event) # ?
		return attack_state # Some way to sense the direction of the attack (in attack or before call)
	elif event.is_action_pressed("aim") && aim_state.available:
		return aim_state
	
func physics_process(delta: float) -> BaseState:
	var axis = get_axis()
	if (axis == Vector2.ZERO): # IDLE
		return idle_state
		
	dir = axis.normalized()
	character.set_blend_position(animation_name, dir)
	
	character.velocity = axis * character.stats.move_speed
	character.move_and_slide()
	return null
