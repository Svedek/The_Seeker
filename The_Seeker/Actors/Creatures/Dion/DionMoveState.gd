extends DionState



func enter(direction: Vector2):
	dir = direction
	character.set_blend_position(animation_name + str(ai_controller.active_stage.movement), dir)
	character.play_animation(animation_name + str(ai_controller.active_stage.movement))
	#ai_controller.active_stage.MOVEMENT.get()
#
#
#
#
#
#
#
#
## Reset active_timer
#func exit() -> Vector2:
	#return super.exit()
#
#
#func process(delta:float) -> BaseState:
	#dir = player_dir()
	#character.set_blend_position(animation_name, dir)
	#
	#return super.process(delta)
#
#
#func prepare_next_action():
	#print("Go off Dion")
	##next_action = ai_controller.active_stage.get_next_move()
#
#
#
#
#
#func input(_event):  #TODO TESTING
	#if Input.is_physical_key_pressed(KEY_V):
		#print(character.get_global_mouse_position())
		#move_to(character.get_global_mouse_position())
#
