extends Line2D

# If needs more util:
	# add more animations for different decays
		# animate width curve?
	# initialize func to set things like color, animation, etc


@onready var _animation_player:AnimationPlayer = $AnimationPlayer

func set_trail(points:Array[Vector2]):
	clear_points()
	for point in points:
		add_point(point)
	_animation_player.play("decay")
