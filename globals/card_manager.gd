extends Node

signal cards_offered(card_ids: Array[String])
signal selection_changed(selected_ids: Array[String])
signal selection_confirmed(selected_ids: Array[String])

var offered_ids: Array[String] = []
var selected_ids: Array[String] = []

const MAX_SELECT := 3

func offer_cards(count: int = 6) -> void:
	offered_ids.clear()
	selected_ids.clear()
	
	var pool = CardDatabase.get_all_ids()
	pool.shuffle()
	
	for i in range(mini(count, pool.size())):
		offered_ids.append(pool[i])
	
	cards_offered.emit(offered_ids)
	selection_changed.emit(selected_ids)

func toggle_card(card_id: String) -> void:
	if card_id in selected_ids:
		selected_ids.erase(card_id)
	else:
		if selected_ids.size() < MAX_SELECT:
			selected_ids.append(card_id)
	
	selection_changed.emit(selected_ids)

func can_confirm() -> bool:
	return selected_ids.size() == MAX_SELECT

func confirm_selection() -> void:
	if can_confirm():
		selection_confirmed.emit(selected_ids)
