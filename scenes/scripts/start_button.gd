extends Button

func _on_pressed() -> void:
	global.start_game.emit()
