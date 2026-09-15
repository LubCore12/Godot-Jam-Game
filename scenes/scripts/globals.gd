extends Control

@onready var cards := $Panel/CardsScroller/Cards
@onready var confirm_button := $GlobalsButtons/GlobalsConfirmButton

var global_card_template = preload("res://scenes/global_card.tscn")
var current_card := ""

func _ready() -> void:
	confirm_button.disabled = true
	for card_data in GlobalsDatabase.globals_data.values():
		var new_card = global_card_template.instantiate()
		cards.add_child(new_card)
		new_card.setup(card_data)
		new_card.check_requirements()
		new_card.pressed.connect(on_global_clicked.bind(card_data["ending_id"]))

func on_global_clicked(id: String) -> void:
	if current_card == id:
		current_card = ""
	else:
		current_card = id
	
	for card in cards.get_children():
		card.set_selected(card.get_id() == current_card)
		
	confirm_button.disabled = current_card == ""

func _on_globals_confirm_button_pressed() -> void:
	if current_card:
		GameState.play_final.emit(current_card)
