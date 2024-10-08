extends Control


@onready var arrow_label: Label = %ArrowLabel
@onready var game_time_label: Label = %GameTimer
@onready var healthbar_base: TextureProgressBar = %HealthBar
@onready var healthbar_white: TextureProgressBar = %HealthBarWhite

var game_time:float = 0.0

func _ready():
	GameManager.update_dion_health.connect(update_dion_health)
	GameManager.update_active_orbs.connect(update_active_orbs)
	
func _process(delta):
	game_time_label.text = str(Time.get_ticks_msec()/1000.0)
	# game_time += delta
	# game_time_label.text = str("%.3f" % (game_time))
	
	# update_health(9-(roundi(game_time*4)%10),roundi((game_time-1.25)/2.5)%10)
	
	
	
func update_dion_health(current_hp:int):
	healthbar_white.value = current_hp


func update_active_orbs(orbs:int):
	healthbar_base.value = healthbar_base.max_value - orbs
	


func update_arrows(count:int):
	arrow_label.text = str(count)


func _on_player_update_arrows(count):
	arrow_label.text = "x" + str(count)
