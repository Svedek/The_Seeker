extends Area2D

const ARROW = preload("res://Assets/Images/Projectile/Arrow.png")


func _ready():
	GameManager.new_stage.connect(dislodge)


func activate():
	monitoring = true
	$"Sprite2D".texture = ARROW


func dislodge():
	#if monitoring == true:  # DONT THINK THIS IS FUN, JUST DONT??
		#return
	activate()
	var pos_tween = create_tween().set_parallel(true)
	# pos_tween.tween_property(self, "position", (Vector2.DOWN.rotated(rotation + randf_range(-0.25*PI, 0.25*PI)) * (16 + randi() % 48)) , 1.0).as_relative().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	pos_tween.tween_property(self, "position", (-global_position.normalized().rotated(randf_range(-0.25*PI, 0.25*PI)) * (32 + randi() % 32)) , 1.0).as_relative().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	pos_tween.tween_property(self, "rotation", randf_range(-1.5*PI, 1.5*PI), 1.0).as_relative().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	await pos_tween.finished




func expell():
	var vector_to_target = Vector2.RIGHT.rotated(randf_range(0,2*PI))  # TODO not done here!!!, use this to decide which way to shoot the arrow PEW!!!
	
	activate()
	var pos_tween = create_tween().set_parallel(true)
	# pos_tween.tween_property(self, "position", (Vector2.DOWN.rotated(rotation + randf_range(-0.25*PI, 0.25*PI)) * (16 + randi() % 48)) , 1.0).as_relative().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	pos_tween.tween_property(self, "position", (-global_position.normalized().rotated(randf_range(-0.25*PI, 0.25*PI)) * (32 + randi() % 32)) , 1.0).as_relative().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	pos_tween.tween_property(self, "rotation", randf_range(-1.5*PI, 1.5*PI), 1.0).as_relative().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	await pos_tween.finished


func _on_body_entered(body):
	body.gain_arrow()
	queue_free()
