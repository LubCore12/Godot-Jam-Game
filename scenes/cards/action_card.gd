class_name ActionCard
extends Resource

@export var id: String
@export var title: String
@export var description: String
@export var icon: Texture2D

@export var effects: Dictionary = {
	# Пример: "food": 20, "alertness": -10
}

@export var requirements: Dictionary = {
	# Пример: "alertness": 40  (нужно минимум 40)
}

func can_be_played(current_stats: Dictionary) -> bool:
	for req in requirements:
		if current_stats.get(req, 0) < requirements[req]:
			return false
	return true
