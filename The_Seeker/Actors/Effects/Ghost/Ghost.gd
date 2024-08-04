extends Sprite2D

@export var ghost_duration: float = 0.5

func _ready():
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, ghost_duration).set_trans(Tween.TRANS_QUART)
	tween.finished.connect(_kill)

func _kill():
	queue_free()
