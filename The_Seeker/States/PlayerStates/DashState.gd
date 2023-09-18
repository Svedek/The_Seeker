extends InputState

#TODO maybe have dash speed influenced by input dir slightly
#TODO if redo movement system to be not snap movement, have dash be boost of speed with input momvement too?

signal dash_charges_update(charges:int)

@export_category("State Transitions")
@export var idle_node: NodePath
@export var run_node: NodePath
@export var attack_node: NodePath # TODO possibly make into dash attack
@export var aim_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var attack_state: BaseState = get_node(attack_node)
@onready var aim_state: BaseState = get_node(aim_node)

@export_category("Data")
@export var _dash_mod: float = 2.0
@export var _dash_time:float = 0.25
@export var _charge_regen_time: float = 0.5
@export var _ghost_delay: float = 0.06
@export var _dash_charges: int = 3

var _dash_timer:Timer
var _charge_regen_timer:Timer
var _dash_ghost_timer:Timer
var _charges: int:
	set(value):
		_charges = value
		emit_signal("dash_charges_update", value)

func _ready():
	print("dash_state TODO : idea")
	self._charges = _dash_charges
	_dash_timer = create_timer (null, _dash_time)
	_charge_regen_timer = create_timer(charge_regen_timeout, _charge_regen_time)
	_charge_regen_timer.one_shot = false
	_dash_ghost_timer = create_timer (instance_ghost, _ghost_delay)
	_dash_ghost_timer.one_shot = false

func _process(delta):
	var partial = 0
	if !_charge_regen_timer.is_stopped():
		partial = (_charge_regen_time-_charge_regen_timer.time_left)/_charge_regen_time
	character.update_stamina(_charges + partial)

func enter(direction: Vector2):
	super.enter(direction)
	character._animation_tree["parameters/Dash/blend_position"] = dir
	_dash_timer.start()
	_charge_regen_timer.stop()
	_dash_ghost_timer.start()
	self._charges -= 1
	available = _charges > 0
	
func exit() -> Vector2:
	_charge_regen_timer.start() #can imagine this would suck to have going on and off, maybe just leave on
	_dash_ghost_timer.stop()
	return dir
	
func input(event):
	if event.is_action_pressed("dash") && available:
		var axis = get_axis()
		if axis:
			dir = axis
		return self
	elif event.is_action_pressed("attack") && attack_state.available:
		attack_state.input(event)
		return attack_state
	elif event.is_action_pressed("aim") && aim_state.available:
		aim_state.input(event)
		return aim_state
	return null
	
func process(delta:float) -> BaseState:
	if _dash_timer.time_left <= 0:
		if get_axis() != Vector2.ZERO:
			return run_state
		else:
			return idle_state
	return null
	
func physics_process(delta: float) -> BaseState:
	character.velocity = dir * character.stats.move_speed * _dash_mod
	character.move_and_slide()
	return null
	
func instance_ghost() -> void:
	character.instance_ghost()
	
func charge_regen_timeout():
	self._charges += 1
	if _charges >= _dash_charges:
		_charge_regen_timer.stop()
	available = true
