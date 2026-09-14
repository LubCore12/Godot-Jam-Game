extends Node

signal cards_offered(cards: Array[String])
signal selection_changed(selected_card: String)
signal selection_confirmed(selected_card: String)

var offered_cards: Array[String] = []
var selected_card := ""

func offer_cards(count: int = 6) -> void:
	offered_cards.clear()
	selected_card = ""
	
	var pool = CardDatabase.get_all_cards()
	pool.shuffle()
	
	for i in range(mini(count, pool.size())):
		offered_cards.append(pool[i])
	
	cards_offered.emit(offered_cards)
	selection_changed.emit(selected_card)

func toggle_card(card: String) -> void:
	if card == selected_card:
		selected_card = ""
	else:
		selected_card = card
	
	selection_changed.emit(selected_card)

func confirm_selection() -> void:
	selection_confirmed.emit(selected_card)
