class_name Health
extends Node

signal dead

@export var _max_health:int = 1
var health:int:
	set(value):
		health = value
		if health <= 0:
			emit_signal("dead")

func _ready():
	health = _max_health
