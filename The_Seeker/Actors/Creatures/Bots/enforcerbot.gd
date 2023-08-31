extends CharacterBody2D


@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _animation_playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")

func _ready():
	velocity = Vector2.DOWN * 15.0
	#_animation_playback.travel("Run")

func _physics_process(delta):
	
	velocity = velocity.rotated(.05)
	_animation_tree["parameters/blend_position"] = velocity
	move_and_slide()
