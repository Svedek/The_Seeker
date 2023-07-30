extends CharacterBody2D

#var _strike_timer: Timer
#@onready var _melee = $Melee

func _ready():
	print("TODO GIVE A HEALTH OBJECT")
	
	#var strike_func = func ():
	#	_melee.activate(Vector2.RIGHT)
	
	#_strike_timer = Timer.new()
	#add_child(_strike_timer)
	#_strike_timer.connect("timeout", strike_func) 
	
	#_strike_timer.start(5)
	
func die():
	queue_free()

func _on_hurtbox_damaged(damage):
	print("dummy_oof: " + str(damage) +  " damage")
