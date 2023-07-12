extends "res://src/Health/health.gd"


signal health_update(current_health,max_health)

enum STATE { IDLE, RUN, GENERIC_HI, DASH, AIM, ATTACK }
var _state:STATE = STATE.IDLE : set = _set_state #, get = _get_state

# Movement
const MOVE_SPEED = 320.0
var _axis:Vector2
#var _last_axis:Vector2

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
			_animation_playback.travel("Attack_0")
			
	_state = new_state


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

# MOVEMENT

func _physics_process(delta):
	_movement_input()
	_handle_movement()


func _movement_input():
	_axis = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	_axis = _axis.limit_length(1.0)
	
	
	
func _handle_movement():
	#var collided = move_and_slide()
	match(_state):
	# Specific States:
		STATE.DASH:
			pass
			velocity = _axis * MOVE_SPEED * DASH_MOD
			move_and_slide()
		STATE.AIM:
			pass
		STATE.ATTACK:
			pass
		_:
			if (_axis == Vector2.ZERO): # IDLE
				_set_state(STATE.IDLE)
				pass #_animation_tree["parameters/Idle/blend_position"] = _last_axis
			else: # RUN
				_set_state(STATE.RUN)
				#_last_axis = _axis
				_animation_tree["parameters/Run/blend_position"] = _axis
				_animation_tree["parameters/Idle/blend_position"] = _axis
				velocity = _axis * MOVE_SPEED
				move_and_slide()

# ACTIONS

func _input(event):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("aim"):
		aim()
	if event.is_action_pressed("attack"):
		attack()


func dash():
	if _dash_available && _state < STATE.GENERIC_HI:
		_set_state(STATE.DASH)
		_animation_tree["parameters/Dash/blend_position"] = _axis
	pass


func end_dash():
	_set_state(STATE.IDLE)


func aim():
	_set_state(STATE.AIM)
	pass


func attack():
	if(_state == STATE.ATTACK):
		pass
	elif(_attack_available && _state < STATE.GENERIC_HI):
		_set_state(STATE.ATTACK)
	
	_animation_tree["parameters/Attack_0/blend_position"] = _axis
	
func end_attack():
	_set_state(STATE.IDLE)

func testing(msg: String):
	print(msg)
