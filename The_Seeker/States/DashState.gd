extends MovementState

#TODO maybe make charges return over time, you can dash while you have a charge but only for as many charges as you have

# Goes to Idle, Run, Dash_Attack?

@export var idle_node: NodePath
@export var run_node: NodePath
@export var dash_attack_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var dash_attack_state: BaseState = get_node(dash_attack_node)


const DASH_MOD = 2
const DASH_TIME = 0.3
const DASH_COOLDOWN_TIME = 0.7
const GHOST_DELAY = 0.2
const DASH_CHARGES = 3

var charges_remaining: int
var _dash_timer:Timer
var _dash_cooldown_timer:Timer
var _dash_ghost_timer:Timer


func dash_available() -> bool:
	return _dash_cooldown_timer.time_left <= 0.0

func _ready():
	print("dash_state TODO : idea")
	_dash_timer = create_timer (dash_end, DASH_TIME)
	_dash_cooldown_timer = create_timer (null, DASH_COOLDOWN_TIME)
	_dash_ghost_timer = create_timer (player.instance_ghost(), GHOST_DELAY)
	_dash_ghost_timer.one_shot = false

func enter():
	super.enter()
	player._animation_tree["parameters/Dash/blend_position"] = player.dir
	player.velocity = player.dir* player.MOVE_SPEED * DASH_MOD
	_dash_timer.start()
	_dash_ghost_timer.start()
	
func exit():
	_dash_cooldown_timer.start()
	_dash_ghost_timer.stop()
	
func input(event):
	if event.is_action_pressed("dash"):
		pass # queue next dash
	return null
	
func process(delta:float) -> BaseState:
	if _dash_timer.time_left <= 0 and !false: # and no dash queued
		if get_axis() != Vector2.ZERO:
			return run_state
		else:
			return idle_state
	return null
	
func dash_end():
	if charges_remaining && true: #and dash queued
		--charges_remaining

func create_timer (function, time) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(time)
	timer.one_shot = true
	timer.connect("timeout", function) 
	return timer