extends DionState


const STRIKE_DISTANCE: float = 16.0


func enter(direction: Vector2):
	move_near_player(STRIKE_DISTANCE)


func on_end_move():
	# start strike
	# moving 0.2 0.4 0.6 0.4 or something like that using similar movment to move
	super.enter(player_dir())  # Start animation faced towards player


func intermission_complete():
	GameManager.new_stage.emit()
	next_action = DionStageAI.ACTION.Idle  # maybe add some delay before returning
	orb_controller.switch_to_bounce()  # TODO temporary, but some orb action should be taken


func exit():
	# Maybe put emitting Gamemanager.new_stage here
	return super.exit()


func attempt_damage() -> bool:
	return false  # damage goes through
