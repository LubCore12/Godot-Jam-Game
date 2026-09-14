extends Node

const SAVE_PATH := "user://savegame.json"

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func save_game() -> void:
	var save_data := {
		"stats": GameState.stats,
		"day": GameState.day,
		"current_phase": GameState.current_phase,
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()

func load_game() -> void:
	if not has_save():
		push_warning("Save file not found")
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text := file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(text)
	if parsed == null:
		push_error("Save file is corrupted")
		return

	var save_data: Dictionary = parsed
	
	print(save_data["stats"])

	GameState.stats = save_data["stats"]
	GameState.day = save_data["day"]
	GameState.current_phase = save_data["current_phase"]

func delete_save() -> void:
	if has_save():
		DirAccess.remove_absolute(SAVE_PATH)
