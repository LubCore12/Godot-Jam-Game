extends Control

@onready var cards = $Panel/CardsScroller/Cards

var global_card_template = preload("res://scenes/global_card.tscn")

func _ready() -> void:
	for card_data in GlobalsDatabase.globals_data.values():
		var new_card = global_card_template.instantiate()
		cards.add_child(new_card)
		new_card.setup(card_data)
