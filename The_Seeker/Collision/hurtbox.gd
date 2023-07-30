extends Area2D

signal damaged(damage:int)

func take_damage(damage:int):
	emit_signal("damaged", damage)
