class_name BookPage
extends Control

@onready var title := $Name
@onready var icon_rect := $Icon
@onready var info := $Info

func set_data(data: Dictionary) -> void:
	title.text = data.get("title", "")
	#icon_rect.texture = data.get("icon", null)
	info.text = data.get("info", "")

func clear() -> void:
	title.text = "None"
	info.text = "NoneNone"
