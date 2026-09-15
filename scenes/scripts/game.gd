extends Node2D

@onready var camera := $Camera
@onready var settings_menu := $Locations/GameWindow/Settings
@onready var inventory_menu := $Locations/GameWindow/Inventory
@onready var people_menu := $Locations/GameWindow/People
@onready var globals_menu := $Locations/GameWindow/Globals
@onready var dialog_menu := $Locations/GameWindow/Dialog
@onready var health_bar := $Locations/GameWindow/StateStats/HealthStat/ProgressBar
@onready var food_bar := $Locations/GameWindow/StateStats/FoodStat/ProgressBar
@onready var sanity_bar := $Locations/GameWindow/StateStats/SanityStat/ProgressBar
@onready var alertness_bar := $Locations/GameWindow/StateStats/AlertnessStat/ProgressBar
@onready var strength_label := $Locations/GameWindow/SecondaryStats/Strength/StrengthLabel
@onready var stealth_label := $Locations/GameWindow/SecondaryStats/Stealth/StealthLabel
@onready var dexterity_label := $Locations/GameWindow/SecondaryStats/Dexternity/DexternityLabel
@onready var speed_label := $Locations/GameWindow/SecondaryStats/Speed/SpeedLabel
@onready var day := $Locations/GameWindow/InfoSidePanel/VBoxContainer/DayPanel/Day
@onready var day_time := $Locations/GameWindow/InfoSidePanel/VBoxContainer/DayTimePanel/DayTime
@onready var day_transition := $Locations/GameWindow/DayTransition
@onready var day_transition_label := $Locations/GameWindow/DayTransition/Label

func _ready() -> void:
	GameState.settings_open.connect(open_settings)
	GameState.exit_settings.connect(exit_settings)
	GameState.inventory_open.connect(open_inventory)
	GameState.exit_inventory.connect(exit_inventory)
	GameState.people_open.connect(open_people)
	GameState.exit_people.connect(exit_people)
	GameState.globals_open.connect(open_globals)
	GameState.exit_globals.connect(exit_globals)
	
	GameState.start_game.connect(start_game)
	GameState.continue_game.connect(continue_game)
	GameState.stats_changed.connect(stats_changed)
	GameState.play_dialog.connect(play_dialog)
	GameState.close_dialog.connect(close_dialog)
	GameState.play_final.connect(play_final)
	
	CardManager.offer_cards(6)
	CardManager.selection_confirmed.connect(selection_confirmed)
	
func start_game() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "offset:x", 1920, 0.5)

func continue_game() -> void:
	SaveManager.load_game()
	var tween = create_tween()
	tween.tween_property(camera, "offset:x", 1920, 0.5)
	stats_changed()

func play_final(final: String) -> void:
	print(final)

func play_dialog(dialog: String) -> void:
	dialog_menu.show()
	dialog_menu.setup(dialog)

func close_dialog() -> void:
	dialog_menu.hide()

func open_settings() -> void:
	settings_menu.show()
		
func exit_settings() -> void:
	settings_menu.hide()
	
func open_inventory() -> void:
	inventory_menu.show()
	
func exit_inventory() -> void:
	inventory_menu.hide()
	
func open_people() -> void:
	people_menu.show()

func exit_people() -> void:
	people_menu.hide()
	
func open_globals() -> void:
	globals_menu.show()
	
func exit_globals() -> void:
	globals_menu.hide()
	
func selection_confirmed(card: String) -> void:
	GameState.current_phase = (GameState.current_phase + 1) % GameState.Phase.size()
	
	if GameState.current_phase == GameState.Phase.MORNING:
		GameState.day += 1
		play_day_transition()
	else:
		set_day_and_phase()
	
	var effects = CardDatabase.get_card(card)["effects"]
	for stat in effects:
		var stat_value = effects[stat]
		GameState.change_stat(stat, stat_value)
	CardManager.offer_cards(6)
	
func set_day_and_phase() -> void:
	day.text = "Day: " + str(GameState.day) + "/" + str(GameState.max_days)
	match GameState.current_phase:
		GameState.Phase.MORNING:
			day_time.text = "Morning"
		GameState.Phase.AFTERNOON:
			day_time.text = "Afternoon"
		GameState.Phase.EVENING:
			day_time.text = "Evening"
	
func play_day_transition() -> void:
	day_transition.show()
	day_transition_label.text = "Day " + str(GameState.day)
	var tween = create_tween()
	tween.tween_property(day_transition, "modulate:a", 1.0, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(0.3)
	tween.tween_callback(set_day_and_phase)
	tween.tween_property(day_transition, "modulate:a", 0.0, 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(day_transition.hide)
	
func stats_changed() -> void:
	health_bar.value = GameState.stats["health"]
	health_bar.get_child(0).text = str(int(GameState.stats["health"])) + "/" + str(int(GameState.max_stats["health"]))
	food_bar.value = GameState.stats["food"]
	food_bar.get_child(0).text = str(int(GameState.stats["food"])) + "/" + str(int(GameState.max_stats["food"]))
	sanity_bar.value = GameState.stats["sanity"]
	sanity_bar.get_child(0).text = str(int(GameState.stats["sanity"])) + "/" + str(int(GameState.max_stats["sanity"]))
	alertness_bar.value = GameState.stats["alertness"]
	alertness_bar.get_child(0).text = str(int(GameState.stats["alertness"])) + "/" + str(int(GameState.max_stats["alertness"]))
	
	strength_label.text = "Lvl: " + str(GameState.stats["strength"])
	stealth_label.text = "Lvl: " + str(GameState.stats["stealth"])
	dexterity_label.text = "Lvl: " + str(GameState.stats["dexterity"])
	speed_label.text = "Lvl: " + str(GameState.stats["speed"])
	
	SaveManager.save_game()
