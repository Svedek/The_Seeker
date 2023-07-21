extends Area2D

const DAMAGE = 1

@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")

func _ready():
	_animation_tree.active = true
	
func activate(dir:Vector2):
	self.rotation = dir.angle()
	_animation_playback.travel("melee_0")


func _on_body_entered(body):
	print("woah")
	body.has_method("take_damage")
	body.take_damage(DAMAGE)
