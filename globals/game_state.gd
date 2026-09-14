extends Node

@warning_ignore_start("unused_signal")

signal start_game
signal continue_game
signal settings_open
signal inventory_open
signal globals_open
signal people_open
signal exit_settings
signal exit_inventory
signal exit_people
signal exit_globals
signal stats_changed
signal phase_changed
signal day_changed
signal game_over(reason: String)

enum Phase { MORNING, AFTERNOON, EVENING }

var day := 1
var max_days := 30
var current_phase := Phase.MORNING

var stats := {
	"health": 100.0,
	"food": 100.0,
	"sanity": 100.0,
	"alertness": 100.0,
	"strength": 0,
	"dexternity": 0,
	"stealth": 0,
	"speed": 0,
	"old_man": 0,
	"rat": 0,
	"gray": 0
}

var max_stats := {
	"health": 100.0,
	"food": 100.0,
	"sanity": 100.0,
	"alertness": 100.0
}

var music_sound := 100
var sfx_sound := 100

func change_stat(stat_name: String, amount: float):
	if not stats.has(stat_name):
		return
	
	stats[stat_name] = clamp(stats[stat_name] + amount, 0.0, max_stats[stat_name])
	stats_changed.emit()
	
	check_game_over()

func check_game_over():
	for stat in stats:
		if stats[stat] <= 0:
			game_over.emit(stat)
			return
