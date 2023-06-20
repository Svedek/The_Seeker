extends "res://src/Health/health.gd"


signal health_update(current_health,max_health)

enum STATE { IDLE, RUN, GENERIC_HI, DASH, AIM, ATTACK }
var _state:STATE = STATE.IDLE : set = _set_state #, get = _get_state

# Movement
const MOVE_SPEED = 320.0
var _axis:Vector2

# Dash
const DASH_MOD = 1.5
var _dash_available = true
var _dash_cooldown_timer:Timer

# Aim


# Attack
var _attack_combo:int = 0
var _attack_available = true
var _attack_cooldown_timer:Timer

@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")


func _set_state(new_state):
	if(new_state == _state):
		return
	
	match(_state):
	# Specific States:
		STATE.ATTACK:
			pass # set melee cooldown
	
	match(new_state):
	# Generic States
		STATE.IDLE:
			_animation_playback.travel("Idle")
		STATE.RUN:
			_animation_playback.travel("Run")
		STATE.GENERIC_HI:
			print("State is Generic_Hi")
	# Specific States:
		STATE.DASH:
			_animation_playback.travel("Dash")
		STATE.AIM:
			_animation_playback.travel("Aim")
		STATE.ATTACK:
			_animation_playback.travel("Attack")
			
	_state = new_state
	
func _to_generic_state(force:bool):
	if (!force and !(_state < STATE.GENERIC_HI)):
		return
	if (_axis == Vector2.ZERO):
		self._state = STATE.RUN
	else:
		self._state = STATE.IDLE

func _create_timer (function, time) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(time)
	timer.one_shot = true
	timer.connect("timeout", function) 
	return timer

func _ready():
	var dash_reset = func ():
		_dash_available = true
		
	_dash_cooldown_timer = _create_timer(dash_reset,0.5)
	
	_animation_tree.active = true
	
func _process(delta):
	_update_animation()

func _physics_process(delta):
	_handle_input()

func _input(event):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("aim"):
		aim()
	if event.is_action_pressed("attack"):
		attack()
		
		
func _handle_input():
		
	_axis = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	_axis = _axis.limit_length(1.0)
	
	velocity = _axis * MOVE_SPEED
	
	var collided = move_and_slide()
	
func _update_animation():
	_animation_tree["parameters/Idle/blend_position"] = _axis
	_animation_tree["parameters/Run/blend_position"] = _axis
	_animation_tree["parameters/Attack/blend_position"] = _axis
	_animation_tree["parameters/Dash/blend_position"] = _axis
	
	
func dash():
	_set_state(STATE.IDLE)
	pass
	
func aim():
	_set_state(STATE.RUN)
	pass
	
func attack():
	_set_state(STATE.ATTACK)
	pass
