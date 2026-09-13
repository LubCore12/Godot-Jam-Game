extends Button

func _on_pressed() -> void:
	global.open_settings.emit()
