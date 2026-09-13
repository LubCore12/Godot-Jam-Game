extends Node

@warning_ignore_start("unused_signal")

signal start_game
signal settings_open
signal exit_settings
signal stats_changed
signal phase_changed
signal day_changed
signal game_over(reason: String)

enum Phase { MORNING, DAY, EVENING }

var day: int = 1
var max_days: int = 30
var current_phase: Phase = Phase.MORNING

var stats = {
	"health": 100.0,
	"food": 100.0,
	"sanity": 100.0,
	"alertness": 100.0
}

var max_stats = {
	"health": 100.0,
	"food": 100.0,
	"sanity": 100.0,
	"alertness": 100.0
}

var music_sound = 100
var sfx_sound = 100

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
