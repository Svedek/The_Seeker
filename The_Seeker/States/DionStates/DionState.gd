extends BaseState
class_name DionState


func player_pos() -> Vector2: # Dir or ref?
	return Player.Instance.position


func intermission_interrupt():
	pass # TODO dodge to center and -> intermission


func damage_interrupt():
	pass
