extends Button

@onready var info_bg = $Info/BG1
@onready var icon_bg = $Icon/BG1
@onready var title = $Info/InfoPanel/Title
@onready var description = $Info/InfoPanel/Description
@onready var card_icon = $Icon/CardIcon

signal card_clicked(card_id: String)

var card_id: String

func _on_mouse_entered() -> void:
	animate_bg(Color.WHITE, Color.WHITE)

func _on_mouse_exited() -> void:
	pass # Replace with function body.

func animate_bg(info_color, icon_color) -> void:
	info_bg.color = info_color
	icon_bg.color = icon_color

func setup(id: String, data: Dictionary) -> void:
	card_id = id
	title.text = data.get("title", "abc")
	description.text = data.get("description", "abc")
	
	if data.has("icon"):
		card_icon.texture = load(data["icon"])
	
	# Подсветка редкости
	match data.get("rarity", "common"):
		"common":
			self_modulate = Color.WHITE
		"uncommon":
			self_modulate = Color(0.75, 0.85, 1.0)
		"rare":
			self_modulate = Color(0.9, 0.75, 1.0)
		"dangerous":
			self_modulate = Color(1.0, 0.65, 0.65)

func set_selected(value: bool) -> void:
	if value:
		scale = Vector2(1.08, 1.08)
		modulate = Color(1.2, 1.2, 1.0)
	else:
		scale = Vector2.ONE
		modulate = Color.WHITE

func _on_pressed() -> void:
	card_clicked.emit(card_id)
