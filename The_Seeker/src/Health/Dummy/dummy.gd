extends "res://src/Health/health.gd"

var _strike_timer: Timer
@onready var _melee = $Melee

func _ready():
	var strike_func = func ():
		_melee.activate(Vector2.RIGHT)
	
	_strike_timer = Timer.new()
	add_child(_strike_timer)
	_strike_timer.connect("timeout", strike_func) 
	
	_strike_timer.start(5)
	
func die():
	queue_free()
