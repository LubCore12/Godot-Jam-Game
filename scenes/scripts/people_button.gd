extends Button

func _on_pressed() -> void:
	GameState.people_open.emit()
