extends BaseState

# Goes to Run, Dash, Attack, Aim
@export var run_node: NodePath
@export var dash_node: NodePath
@export var attack_node: NodePath
@export var aim_node: NodePath

@onready var run_state: BaseState = get_node(run_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var attack_state: BaseState = get_node(attack_node)
@onready var aim_state: BaseState = get_node(aim_node)


func enter() -> void:
	super.enter()
	player.velocity = Vector2.ZERO #?

func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("dash"):
		return dash_state
	elif event.is_action_pressed("attack"):
		attack_state.input(event) # ?
		return attack_state # Some way to sense the direction of the attack (in attack or before call)
	elif event.is_action_pressed("aim"):
		return aim_state
	
	var axis: Vector2 = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	if axis != Vector2.ZERO:
		return run_state
	return null

#func physics_process(delta: float) -> BaseState:
#	player.move_and_slide()
#	return null