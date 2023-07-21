class_name Player
extends CharacterBody2D


signal health_update(current_health,max_health)

enum STATE { IDLE, RUN, GENERIC_HI, DASH, AIM, ATTACK }
var _state:STATE = STATE.IDLE : set = _set_state #, get = _get_state

var dir :Vector2 = Vector2.UP
# Movement
const MOVE_SPEED = 240.0
var _axis:Vector2
#var _last_axis:Vector2

# Dash
const DASH_MOD = 2
const DASH_COOLDOWN_TIME = 1
var _dash_available = true
var _dash_cooldown_timer:Timer

# Aim


# Attack
var _attack_combo:int = 0
var _attack_available = true
var _attack_cooldown_timer:Timer


var _ghost_scene = preload("res://Misc/ghost.tscn")

@onready var _sprite = $Sprite
@onready var _melee = $Melee
@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")


@onready var state_manager : StateManager = $StateManager



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
		
	_dash_cooldown_timer = _create_timer(dash_reset,1)
	
	_animation_tree.active = true

# MOVEMENT

func _physics_process(delta):
	movement_input()
	handle_movement()


func movement_input():
	_axis = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	_axis = _axis.limit_length(1.0)
	
	
	
func handle_movement():
	#var collided = move_and_slide()
	match(_state):
	# Specific States:
		STATE.DASH:
			# velocity is set in dash()
			move_and_slide()
		STATE.AIM:
			pass
		STATE.ATTACK:
				velocity = _axis * MOVE_SPEED * 0.5
				move_and_slide()
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

func _unhandled_input(event):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("aim"):
		aim()
	if event.is_action_pressed("attack"):
		# Calculate attack dir
		var dir: Vector2
		if event is InputEventMouseButton:
			dir = get_global_mouse_position() - self.position
		else:
			print("_input else") # code for controller users :bleh: ;p
		attack(dir)
	
	
	state_manager.input(event)


func dash():
	if _dash_available && _state < STATE.GENERIC_HI:
		_set_state(STATE.DASH)
		_animation_tree["parameters/Dash/blend_position"] = _axis
		_dash_cooldown_timer.start(1)
		
		velocity = _axis * MOVE_SPEED * DASH_MOD


func end_dash(): # Possibly covert all end_... to one end_state
	_set_state(STATE.IDLE)


func aim():
	_set_state(STATE.AIM)
	pass


func attack(dir:Vector2):
	if(!_attack_available || _state > STATE.GENERIC_HI ):
		pass
	_set_state(STATE.ATTACK)
	_melee.activate(dir)
	_animation_tree["parameters/Attack_0/blend_position"] = dir
	
func end_attack():
	_set_state(STATE.IDLE)


func instance_ghost():
	var ghost: Sprite2D = _ghost_scene.instantiate()

	get_parent().add_child(ghost)
	
	ghost.global_position = _sprite.global_position
	ghost.texture = _sprite.texture
	ghost.hframes = _sprite.hframes
	ghost.vframes = _sprite.vframes
	ghost.frame = _sprite.frame

func testing(msg: String):
	print(msg)
