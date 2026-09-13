extends Button

func _on_pressed() -> void:
	GameState.settings_open.emit()
