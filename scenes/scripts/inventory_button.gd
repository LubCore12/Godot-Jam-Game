extends Button

func _on_pressed() -> void:
	GameState.inventory_open.emit()
