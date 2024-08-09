extends Node

signal new_stage()

func _input(event): # TODO TESTING
	testing()
	

func orb_shot(): # TODO
	print("GameManager.orb_shot")


func testing():
	var dion = $Dion
	if dion:
		if Input.is_physical_key_pressed(KEY_1):
			pass
		if Input.is_physical_key_pressed(KEY_2):
			pass
	if Input.is_physical_key_pressed(KEY_9):
		new_stage.emit()
	
