extends Node

signal new_stage()
signal update_dion_health(health: int)
signal update_orb_health(orbs: int)

func _input(event): # TODO TESTING
	testing()
	

func orb_shot(): # TODO
	print("GameManager.orb_shot")


var test_hp = 9
var test_orb = 9
func testing():
	if Input.is_physical_key_pressed(KEY_1):
		update_dion_health.emit(test_hp)
		test_hp -=1
	if Input.is_physical_key_pressed(KEY_2):
		update_orb_health.emit(test_orb)
		test_orb -=1
	if Input.is_physical_key_pressed(KEY_9):
		new_stage.emit()
