extends Control


@onready var menu_hallway = $SubViewport/MenuHallway
@onready var title_screen = $TitleScreen
@onready var options_screen = $OptionsScreen

const ARENA = preload("res://Actors/World/arena.tscn")


func _ready():
	recenter()


func _process(delta):
	pass


func recenter():
	position = -size/2


func _on_start_button_pressed():
	menu_hallway.animate_play()


func _on_options_button_pressed():
	menu_hallway.animate_options_enter()


func _on_options_return_button_pressed():
	menu_hallway.animate_options_exit()


func _on_exit_button_pressed():
	menu_hallway.animate_exit()


func _on_menu_hallway_start_reached():
	get_tree().change_scene_to_packed(ARENA)


func _on_menu_hallway_options_reached():
	title_screen.visible = false
	options_screen.visible = true


func _on_menu_hallway_options_left():
	title_screen.visible = true
	options_screen.visible = false


func _on_menu_hallway_exit_reached():
	get_tree().quit()
