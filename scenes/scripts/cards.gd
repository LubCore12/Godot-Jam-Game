extends Control

@onready var container := $ChoiceMenu
@onready var confirm_button := $ConfirmPanel/ConfirmButton

var card_scene = preload("res://scenes/card.tscn")
var card_nodes := {}

func _ready() -> void:
	CardManager.cards_offered.connect(on_cards_offered)
	CardManager.selection_changed.connect(on_selection_changed)
	confirm_button.disabled = true

func on_cards_offered(ids: Array[String]) -> void:
	for child in container.get_children():
		child.queue_free()
	card_nodes.clear()
	
	for id in ids:
		var data = CardDatabase.get_card(id)
		var inst = card_scene.instantiate()
		container.add_child(inst)
		inst.setup(id, data)
		inst.card_clicked.connect(on_card_clicked)
		card_nodes[id] = inst
		inst.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL 
		inst.size_flags_vertical = Control.SIZE_EXPAND | Control.SIZE_FILL

func on_card_clicked(card: String) -> void:
	CardManager.toggle_card(card)

func on_selection_changed(selected: String) -> void:
	for card in card_nodes:
		card_nodes[card].set_selected(card == selected)
	confirm_button.disabled = selected == ""

func _on_confirm_button_pressed() -> void:
	CardManager.confirm_selection()
