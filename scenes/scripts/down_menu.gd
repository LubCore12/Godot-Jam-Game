extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		if child is Button:
			setup_button(child)

func setup_button(button: Button) -> void:
	var style: StyleBoxFlat = button.get_theme_stylebox("normal").duplicate()
	button.add_theme_stylebox_override("normal", style)
	button.add_theme_stylebox_override("hover", style)
	button.add_theme_stylebox_override("pressed", style)
	button.add_theme_stylebox_override("focus", style)

	button.mouse_entered.connect(button_mouse_entered.bind(button))
	button.mouse_exited.connect(button_mouse_exited.bind(button))
	button.button_down.connect(button_down.bind(button))
	button.button_up.connect(button_up.bind(button))

func button_mouse_entered(button: Button) -> void:
	animate_button(button, Colors.hover_bg, Colors.hover_border)

func button_mouse_exited(button: Button) -> void:
	animate_button(button, Colors.basic_bg, Colors.basic_border)

func button_down(button: Button) -> void:
	change_button(button, Colors.pressed_bg, Colors.pressed_border)

func button_up(button: Button) -> void:
	change_button(button, Colors.basic_bg, Colors.basic_border)

func change_button(button: Button, bg: Color, border: Color) -> void:
	var style: StyleBoxFlat = button.get_theme_stylebox("normal")
	style.bg_color = bg
	style.border_color = border

func animate_button(button: Button, bg: Color, border: Color) -> void:
	var style: StyleBoxFlat = button.get_theme_stylebox("normal")
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(style, "bg_color", bg, 0.15)
	tween.tween_property(style, "border_color", border, 0.15)
