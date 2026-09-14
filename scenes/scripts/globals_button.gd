extends Button

func _on_pressed() -> void:
	GameState.globals_open.emit()
