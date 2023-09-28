extends EnemyState
class_name EnemyConstantMoveState

@export var move_speed:float
var target:Vector2

func _physics_process(delta):
	character.velocity = Vector2.ZERO.move_toward(Vector2.ONE*2, move_speed)
	character.move_and_slide()
