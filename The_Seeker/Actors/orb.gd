extends Area2D

signal pierced
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	GameManager.new_stage.connect(activate)

func activate():
	monitorable = true
	animation_player.play("active")

func orb_pierced():
	monitorable = false
	animation_player.play("deactive")
