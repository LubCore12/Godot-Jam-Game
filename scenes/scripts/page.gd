class_name BookPage
extends Control

@onready var title := $Name
@onready var icon_rect := $Icon
@onready var info := $Info
@onready var talk_button := $TalkButton

var dialog_info := ""

func set_data(data: Dictionary) -> void:
	title.text = data["title"]
	#icon_rect.texture = data.get("icon", null)
	info.text = data["info"]
	dialog_info = data["id"]

func clear() -> void:
	title.text = "None"
	info.text = "NoneNone"
	dialog_info = ""
	talk_button.hide()

func _on_talk_button_pressed() -> void:
	print(dialog_info)
	GameState.play_dialog.emit(dialog_info)
