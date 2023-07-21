extends Sprite2D

func _ready():
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 2).set_trans(Tween.TRANS_QUART)
	tween.finished.connect(_kill)

func _kill():
	queue_free()
