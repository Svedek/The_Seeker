extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 2).set_trans(Tween.TRANS_QUART)
	tween.finished.connect(_kill)

func _kill():
	queue_free()
