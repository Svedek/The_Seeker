extends Node

signal new_stage()

func _input(event): # TODO TESTING
	if Input.is_physical_key_pressed(KEY_9):
		new_stage.emit()

func orb_shot(): # TODO
	print("GameManager.orb_shot")
