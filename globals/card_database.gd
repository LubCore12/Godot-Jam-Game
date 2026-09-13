extends Node

const cards_data = {
	"eat_ration": {
		"title": "Поесть",
		"description": "Съесть дневной паёк",
		"rarity": "common",
		"effects": {"food": 25, "alertness": -5},
		"requirements": {},
		"tags": ["basic"]
	},
	"rest": {
		"title": "Отдохнуть",
		"description": "Попытаться поспать",
		"rarity": "common",
		"effects": {"health": 10, "sanity": 8, "alertness": -20},
		"requirements": {},
		"tags": ["basic"]
	},
	"listen": {
		"title": "Прислушаться",
		"description": "Слушать, что происходит в коридоре",
		"rarity": "common",
		"effects": {"alertness": 15, "sanity": -5},
		"requirements": {},
		"tags": ["info"]
	},
	"train": {
		"title": "Тренировать тело",
		"description": "Заняться физическими упражнениями",
		"rarity": "uncommon",
		"effects": {"health": 12, "food": -10, "alertness": 5},
		"requirements": {"food": 20},
		"tags": ["physical"]
	},
	"eat_ration2": {
		"title": "Поесть",
		"description": "Съесть дневной паёк",
		"rarity": "common",
		"effects": {"food": 25, "alertness": -5},
		"requirements": {},
		"tags": ["basic"]
	},
	"rest2": {
		"title": "Отдохнуть",
		"description": "Попытаться поспать",
		"rarity": "common",
		"effects": {"health": 10, "sanity": 8, "alertness": -20},
		"requirements": {},
		"tags": ["basic"]
	},
	"listen2": {
		"title": "Прислушаться",
		"description": "Слушать, что происходит в коридоре",
		"rarity": "common",
		"effects": {"alertness": 15, "sanity": -5},
		"requirements": {},
		"tags": ["info"]
	},
	"train2": {
		"title": "Тренировать тело",
		"description": "Заняться физическими упражнениями",
		"rarity": "uncommon",
		"effects": {"health": 12, "food": -10, "alertness": 5},
		"requirements": {"food": 20},
		"tags": ["physical"]
	},
}

func get_card(id: String) -> Dictionary:
	return cards_data.get(id, {})

func get_all_ids() -> Array[String]:
	return cards_data.keys()
