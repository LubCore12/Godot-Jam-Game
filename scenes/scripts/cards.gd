extends Control

@onready var container: GridContainer = $ChoiceMenu
@onready var confirm_btn: Button = $ConfirmPanel/ConfirmButton

var card_scene = preload("res://scenes/card.tscn")
var card_nodes: Dictionary = {}

func _ready() -> void:
	CardManager.cards_offered.connect(_on_cards_offered)
	CardManager.selection_changed.connect(_on_selection_changed)
	confirm_btn.pressed.connect(_on_confirm_pressed)
	confirm_btn.disabled = true

func _on_cards_offered(ids: Array[String]) -> void:
	for child in container.get_children():
		child.queue_free()
	card_nodes.clear()
	
	for id in ids:
		var data = CardDatabase.get_card(id)
		var inst = card_scene.instantiate()
		container.add_child(inst)
		inst.setup(id, data)
		inst.card_clicked.connect(_on_card_clicked)
		card_nodes[id] = inst
		inst.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		inst.size_flags_vertical = Control.SIZE_EXPAND_FILL

func _on_card_clicked(card_id: String) -> void:
	CardManager.toggle_card(card_id)

func _on_selection_changed(selected: Array[String]) -> void:
	for id in card_nodes:
		card_nodes[id].set_selected(id in selected)
	
	confirm_btn.disabled = not CardManager.can_confirm()

func _on_confirm_pressed() -> void:
	CardManager.confirm_selection()
