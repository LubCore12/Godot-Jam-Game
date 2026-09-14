extends Control

var temp_music: float
var temp_sfx: float

func _on_exit_pressed() -> void:
	GameState.exit_settings.emit()

func _on_save_pressed() -> void:
	GameState.music_sound = int(temp_music)
	GameState.sfx_sound = int(temp_sfx)
	
func _on_save_exit_pressed() -> void:
	GameState.music_sound = int(temp_music)
	GameState.sfx_sound = int(temp_sfx)
	GameState.exit_settings.emit()

func _on_sfx_slider_value_changed(value: float) -> void:
	temp_sfx = value

func _on_music_slider_value_changed(value: float) -> void:
	temp_music = value
