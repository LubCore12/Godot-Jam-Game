extends Node

const globals_data = {
	"uprising": {
		"title": "Восстание",
		"description": "Поднять бунт вместе с другими заключёнными",
		"text_requirements": "Requirements: Old Man trust: 60, Rat trust: 40",
		"unlocked": false,
		"completed": false,
		"requirements": {
			"stats": {
				"old_man": 60,
				"rat": 40
			}
		},
		"ending_id": "ending_uprising"
	},
	
	"informant": {
		"title": "Стать информатором",
		"description": "Начать сотрудничать с охраной",
		"text_requirements": "Requirements: Gray trust: 70",
		"unlocked": false,
		"completed": false,
		"requirements": {
			"stats": {
				"gray": 70
			}
		},
		"ending_id": "ending_informant"
	},
	
	"escape_strength": {
		"title": "Побег силой",
		"description": "Прорваться через охрану",
		"text_requirements": "Requirements: strength: 5",
		"unlocked": false,
		"completed": false,
		"requirements": {
			"stats": {
				"strength": 5
			}
		},
		"ending_id": "ending_escape_force"
	},
	
	"escape_stealth": {
		"title": "Тихий побег",
		"description": "Выбраться незамеченным",
		"text_requirements": "Requirements: stealth: 3, dexternity: 4",
		"unlocked": false,
		"completed": false,
		"requirements": {
			"stats": {
				"stealth": 4,
				"dexterity": 3
			}
		},
		"ending_id": "ending_escape_stealth"
	}
}
