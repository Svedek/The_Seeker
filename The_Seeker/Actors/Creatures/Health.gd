class_name Health
extends Node


signal death

@export var _max_health:int = 1
var health:int:
	set(value):
		health = value
		if health <= 0:
			death.emit()

func _ready():
	if _max_health > 0:  # kinda scuffed, but it works
		health = _max_health
