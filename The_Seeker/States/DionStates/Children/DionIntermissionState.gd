extends DionState



# hitboxes/ being active needs to be disabled at start and re-enabled at end of intermission

func enter(direction: Vector2):
	character.dodge_to(Vector2.ZERO)  # Go to center of stage
	character.move_complete.connect(on_move_complete)


func on_move_complete():  # Once dash to center complete
	character.move_complete.disconnect(on_move_complete)
	super.enter(Vector2.DOWN)  # Face down
	pass  # TODO Start intermission (maybe handled in animation)
	#animation handles orb_controller.switch_to_return()
	#animation handles new stage call (where?)
	#animation calls intermission_complete


func intermission_complete():
	next_action = DionStageAI.ACTION.Idle  # maybe add some delay before returning

