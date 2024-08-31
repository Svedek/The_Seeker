extends DionState



# hitboxes/ being active needs to be disabled at start and re-enabled at end of intermission

func enter(direction: Vector2):
	dodge_to(Vector2.ZERO)  # Go to center of stage
	


func end_move():  # Overridable, called when move reached destination
	orb_controller.switch_to_return()
	#super.enter(Vector2.DOWN)  # Start animation faced down, which calls intermission_complete when done
	#dir = direction
	#character.set_blend_position(animation_name, dir)
	character.play_animation(animation_name)
	super.end_move()


func intermission_complete():
	GameManager.new_stage.emit()
	next_action = DionStageAI.ACTION.Idle  # maybe add some delay before returning
	orb_controller.switch_to_bounce()  # TODO temporary, but some orb action should be taken


func exit():
	# Maybe put emitting Gamemanager.new_stage here
	return super.exit()


func attempt_damage() -> bool:
	return false  # damage goes through


func intermission_interrupt():
	push_error("INTERMISSION INTERRUPT SHOULD NOT HAPPEN IN DIONINTERMISSIONSTATE")
