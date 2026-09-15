extends Node

const dialogs_data = {
	"old_man": {
		"start": {
			"speaker": "Bob",
			"text": "АААААААААААААА",
			"portrait": preload("res://icon.svg"),
			"choices": [
				{"text": "Отлично!", "next": "bob_good"},
				{"text": "Бывало и лучше...", "next": "bob_bad"},
				{"text": "Не твоё дело.", "next": "bob_rude"},
			]
		},
		"bob_good": {
			"speaker": "Bob",
			"text": "Рад слышать!",
			"portrait": preload("res://icon.svg"),
			"choices": [
				{"text": "Пока!", "next": ""}
			]
		},
		"bob_bad": {
			"speaker": "Bob",
			"text": "Соболезную. Расскажешь?",
			"portrait": preload("res://icon.svg"),
			"choices": [
				{"text": "Не сейчас.", "next": ""}
			]
		},
		"bob_rude": {
			"speaker": "Bob",
			"text": "Ну и ладно.",
			"portrait": preload("res://icon.svg"),
			"choices": [
				{"text": "...", "next": ""}
			]
		}
	}
}
