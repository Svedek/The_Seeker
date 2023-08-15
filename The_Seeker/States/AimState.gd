extends InputState

# TODO lockon

# TODO start game -> melee -> dash   bug?

@export_category("State Transitions")
@export var idle_node: NodePath
@export var run_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)

@export_category("Data")
@export var _decay_trail: PackedScene
@export var _shapecast_shape: Shape2D
@export_flags_2d_physics var _wall_collision_mask: int = 1 << 0
@export_flags_2d_physics var _damage_collision_mask: int = 1 << 7
@export var _raycast_length: float = 1024.0

const NUM_TRAILS = 9
const SHOT_DAMAGE = 3

var _arrows: int = 5
var _raycast: RayCast2D
var _shapecast: ShapeCast2D
var _trails: Array
var _trails_index: int : 
	set(value):
		_trails_index = value % NUM_TRAILS

var _mouse_mode: bool = true

func _ready():
	_raycast = RayCast2D.new()
	add_child(_raycast)
	_raycast.collision_mask = _wall_collision_mask
	
	_shapecast = ShapeCast2D.new()
	add_child(_shapecast)
	_shapecast.collision_mask = _damage_collision_mask
	_shapecast.collide_with_areas = true
	_shapecast.collide_with_bodies = false
	_shapecast.shape = _shapecast_shape
	
	_trails = Array()
	for i in range(NUM_TRAILS):
		_trails.append(_decay_trail.instantiate())
		add_child(_trails[i])

func exit() -> Vector2:
	return super.exit()
	
func input(event):
	if event.is_action_released("aim"):
		if get_axis() != Vector2.ZERO:
			return run_state
		else:
			return idle_state
		
	if event.is_action_pressed("attack"):
		_mouse_mode = event is InputEventMouseButton # maybe temp
		var new_dir: Vector2
		if event is InputEventMouseButton:
			new_dir = player.get_global_mouse_position() - player.position
		else:
			new_dir = get_axis()
		if new_dir != Vector2.ZERO:
			dir = new_dir.normalized()
		
		_raycast.position = player._firepoint.global_position
		_raycast.target_position = player.get_global_mouse_position() - _raycast.position
		_raycast.target_position = _raycast.target_position.normalized() * _raycast_length
		_raycast.force_raycast_update()
		
		_shapecast.position = _raycast.position
		_shapecast.target_position = _raycast.get_collision_point()-_raycast.position
		_shapecast.force_shapecast_update()
		
		for i in range(_shapecast.collision_result.size()):
			var collider = _shapecast.collision_result[i].collider
			if collider.has_method("take_damage"):
				collider.take_damage(SHOT_DAMAGE)
			if collider.has_method("ORB_METHOD"): # TODO APPLY KNOCKBACK AND DISABLE ORBS
				pass
		
		var points : Array[Vector2] = [player._firepoint.global_position, _raycast.get_collision_point()]
		_trails[_trails_index].set_trail(points)
		_trails_index += 1

func process(delta:float) -> BaseState:
	var new_dir: Vector2
	if _mouse_mode:
		new_dir = player.get_global_mouse_position() - player.position
	else:
		new_dir = get_axis()
	if new_dir != Vector2.ZERO:
		dir = new_dir.normalized()
		
	player.set_blend_position(animation_name, dir)
	player.set_weapon_pivot_dir(dir)
	return null
