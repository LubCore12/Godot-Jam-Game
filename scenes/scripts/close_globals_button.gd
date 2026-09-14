extends Button

func _on_pressed() -> void:
	GameState.exit_globals.emit()
