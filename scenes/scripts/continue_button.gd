extends Button

func _ready() -> void:
	disabled = not SaveManager.has_save()

func _on_pressed() -> void:
	GameState.continue_game.emit()
