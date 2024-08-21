extends DionState



# hitboxes/ being active needs to be disabled at start and re-enabled at end of intermission

func enter(direction: Vector2):
	character.dodge_to(Vector2.ZERO)  # Go to center of stage
	character.move_complete.connect(on_move_complete)


func on_move_complete():  # Once dash to center complete
	character.move_complete.disconnect(on_move_complete)
	orb_controller.switch_to_return()
	super.enter(Vector2.DOWN)  # Start animation faced down, which calls intermission_complete when done


func intermission_complete():
	next_action = DionStageAI.ACTION.Idle  # maybe add some delay before returning
	GameManager.new_stage.emit()


func attempt_damage() -> bool:
	return false  # damage goes through
