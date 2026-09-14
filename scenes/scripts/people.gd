extends Control

var current_spread := 0

@onready var left_page := $Book/LeftPage
@onready var right_page := $Book/RightPage
@onready var previous_button := $PrevButton
@onready var next_button := $NextButton

func _ready() -> void:
	render_page(current_spread)

func render_page(spread_index: int) -> void:
	var left_num := spread_index * 2 + 1
	var right_num := spread_index * 2 + 2

	left_page.set_data(PeopleDatabase.people_data[left_num])

	if PeopleDatabase.people_data.has(right_num):
		right_page.set_data(PeopleDatabase.people_data[right_num])
	else:
		right_page.clear()

	current_spread = spread_index
	update_buttons()

func update_buttons() -> void:
	$PrevButton.disabled = current_spread <= 0
	$NextButton.disabled = not PeopleDatabase.people_data.has((current_spread + 1) * 2 + 1)

func _on_next_button_pressed() -> void:
	render_page(current_spread + 1)

func _on_prev_button_pressed() -> void:
	render_page(current_spread - 1)
