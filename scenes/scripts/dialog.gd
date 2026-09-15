extends Control

@onready var dialog_label := $DialogPanel/Label
@onready var person_icon := $PersonIcon
@onready var variants := $Variants

@export var letter_time := 0.05
@export var space_time := 0.075
@export var comma_time := 0.185
@export var punctuation_time := 0.3
@export var dialog_wait_time := 0.7

signal made_choice

var dialog_button_scene = preload("res://scenes/dialog_button.tscn")
var current_id: String

func setup(dialog: String) -> void:
	current_id = "start"
	
	while current_id != "":
		await show_dialog(dialog)
		
	GameState.close_dialog.emit()
	
func show_dialog(dialog: String):
	var current_dialog: Dictionary = DialogsDatabase.dialogs_data[dialog][current_id]
	var dialog_text: String = current_dialog["text"]
	var choices: Array = current_dialog["choices"]
	
	variants.hide()
	await display_text(dialog_text)
	variants.show()
	
	for variant in variants.get_children():
		variant.queue_free()
	
	for choice_index in choices.size():
		var new_button = dialog_button_scene.instantiate()
		variants.add_child(new_button)
		var button_text = choices[choice_index]["text"]
		var button_next = choices[choice_index]["next"]
		new_button.set_text(button_text)
		new_button.pressed.connect(on_variant_pressed.bind(button_next))
	
	await made_choice

func on_variant_pressed(next: String) -> void:
	current_id = next
	made_choice.emit()

func display_text(text: String):
	dialog_label.text = text
	dialog_label.visible_characters = 0
	var total_chars = dialog_label.get_total_character_count()
	
	for i in range(total_chars):
		dialog_label.visible_characters += 1
		var current_char = dialog_label.get_parsed_text()[i]
		
		if current_char == " ":
			await get_tree().create_timer(space_time).timeout
		elif current_char == ",":
			await get_tree().create_timer(comma_time).timeout
		elif current_char in [".", "!", "?", "-"]:
			await get_tree().create_timer(punctuation_time).timeout
		else:
			await get_tree().create_timer(letter_time).timeout
		
