extends MovementState


@export var idle_node: NodePath
@export var run_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)

const MOVE_MOD = 0.5

var _active: bool = false
var _queued_input: InputEvent

var _attack_timer:Timer
var _attack_cooldown_timer:Timer
var _attack_queued: bool # null if no attack queued, dir of attack if queued
var _current_attack: int = 1

@export var _attack_durrations:Array[float]

func _ready():
	print("TODO AttackState: Idea") # idea: initial boost of speed in dir of attack so player will always be moving durring attack, requires vel based movement system
	
	_attack_timer = create_timer(null, 1.0)
	_attack_cooldown_timer = create_timer(null, 1.0)
	
func enter(direction: Vector2):
	dir = direction
	_active = true
	input(_queued_input)
	
func exit() -> Vector2:
	_active = false
	_current_attack = 1
	return super.exit()

func input(event):
	if event.is_action_pressed("attack"):
		if !_active:
			_queued_input = event
			return
		if  _current_attack <= _attack_durrations.size() && !_attack_queued:
			var new_dir: Vector2
			if event is InputEventMouseButton:
				new_dir = player.get_global_mouse_position() - player.position
			else:
				new_dir = get_axis()
			
			if new_dir != Vector2.ZERO:
				dir = new_dir
				
			print(dir)
			_attack_queued = true
	
func process(delta:float) -> BaseState:
	if _attack_timer.time_left <= 0.0:
		if _attack_queued:
			attack()
		else:
			if get_axis() != Vector2.ZERO:
				return run_state
			else:
				print(" --- " + str(dir))
				return idle_state
	return null
	
func physics_process(delta: float) -> BaseState:
	player.velocity = get_axis() * player.MOVE_SPEED * MOVE_MOD
	player.move_and_slide()
	return null

func attack():
	print("Attack: " + str(_current_attack))
	player.play_animation(animation_name + str(_current_attack))
	player.set_blend_position(animation_name + str(_current_attack), dir)
	_attack_timer.start(_attack_durrations[_current_attack-1])
	_attack_cooldown_timer.start()
	_attack_queued = false
	_current_attack += 1
