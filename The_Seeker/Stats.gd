extends Node

signal dead

@export var _max_health:int = 1
var health:int:
	set(value):
		health = _max_health

func _ready():
	health = _max_health
