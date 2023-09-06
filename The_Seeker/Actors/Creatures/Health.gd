class_name Health
extends Node

@export var _max_health:int = 1
var health:int:
	set(value):
		health = value
		if health <= 0:
			on_death()

func _ready():
	health = _max_health

func on_death():
	print("on_death not implemented - " + self.name)
