extends CharacterBody2D


@export var _health : int = 3

func take_damage(damage:int):
	_health -= damage
	if _health <= 0:
		die()
		
func die():
	print("Health: " + self.name + " does not have implemented die")
