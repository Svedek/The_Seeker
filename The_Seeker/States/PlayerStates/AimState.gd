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
@export var _arrow_collectable: PackedScene
@export var _shapecast_shape: Shape2D
@export_flags_2d_physics var _wall_collision_mask: int = 1 << 0
@export_flags_2d_physics var _damage_collision_mask: int = 1 << 7
@export var _raycast_length: float = 1024.0

const NUM_TRAILS = 9
const SHOT_DAMAGE = 3

var _raycast: RayCast2D
var _shapecast: ShapeCast2D
var _trails: Array
var _trails_index: int : 
	set(value):
		_trails_index = value % NUM_TRAILS

#var _mouse_mode: bool = true

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
		if !character.attempt_use_arrow():  # don't fire an arrow if player doesn't have enough arrows
			return
		#_mouse_mode = event is InputEventMouseButton # maybe temp
		var new_dir: Vector2
		var target_position: Vector2
		if event is InputEventMouseButton:
			new_dir = character.get_global_mouse_position() - character.position
			target_position = character.get_global_mouse_position() - character._firepoint.global_position
		else:
			new_dir = get_axis()
			target_position = dir
			if new_dir != Vector2.ZERO:
				target_position = new_dir 
		
		if new_dir != Vector2.ZERO:
			dir = new_dir.normalized()
		
		_raycast.position = character._firepoint.global_position
		_raycast.target_position = target_position.normalized() * _raycast_length
		_raycast.force_raycast_update()
		
		_shapecast.position = _raycast.position
		_shapecast.target_position = _raycast.get_collision_point()-_raycast.position
		_shapecast.force_shapecast_update()
		
		var orb_hit = false
		for i in range(_shapecast.collision_result.size()):
			var collider = _shapecast.collision_result[i].collider
			if collider.has_method("take_damage"):
				collider.take_damage(SHOT_DAMAGE)
			if collider.has_method("orb_pierced"): # TODO APPLY KNOCKBACK AND DISABLE ORBS
				collider.orb_pierced()
				collider.position = _raycast.get_collision_point()
				orb_hit = true
		var arrow = _arrow_collectable.instantiate()
		get_tree().root.add_child(arrow)
		arrow.global_position = _raycast.get_collision_point()
		arrow.rotate((_raycast.get_collision_point() - character._firepoint.global_position).angle())
		if !orb_hit:
			arrow.activate()
		
		var points : Array[Vector2] = [character._firepoint.global_position, _raycast.get_collision_point()]
		_trails[_trails_index].set_trail(points)
		_trails_index += 1


func process(delta:float) -> BaseState:
	var new_dir: Vector2
	new_dir = character.get_global_mouse_position() - character.position
	#if _mouse_mode:
		#new_dir = character.get_global_mouse_position() - character.position
	#else:
		#new_dir = get_axis()
		
	if new_dir != Vector2.ZERO:
		dir = new_dir.normalized()
		
	character.set_blend_position(animation_name, dir)
	character.set_weapon_pivot_dir(dir)
	return null


func _on_player_update_arrows(count):
	available = count > 0
