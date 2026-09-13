extends Node2D

@onready var camera = $Camera
@onready var settings_button = $Locations/GameWindow/DownMenu/Settings
@onready var settings_menu = $Locations/GameWindow/Settings

func _ready() -> void:
	GameState.settings_open.connect(open_settings)
	GameState.start_game.connect(start_game)
	GameState.exit_settings.connect(exit_settings)
	CardManager.offer_cards(6)
	
func start_game() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "offset:x", 1920, 0.5)

func open_settings() -> void:
	settings_menu.show()
		
func exit_settings() -> void:
	settings_menu.hide()
