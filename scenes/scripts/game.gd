extends Node2D

@onready var camera = $Camera
@onready var settings_button = $Locations/GameWindow/DownMenu/Settings
@onready var settings_menu = $Locations/GameWindow/Settings

func _ready() -> void:
	global.start_game.connect(start_game)
	global.open_settings.connect(open_settings)
	
func start_game() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "offset:x", 1920, 0.5)

func open_settings() -> void:
	if settings_menu.visible:
		settings_menu.hide()
	else:
		settings_menu.show()
