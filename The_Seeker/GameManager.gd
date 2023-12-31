extends Node

signal new_stage()

func _input(event):
	
	if Input.is_physical_key_pressed(KEY_9):
		new_stage.emit()
