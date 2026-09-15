extends Button

@onready var title := $Info/BasePanel/Title
@onready var info := $Info/BasePanel/Info
@onready var requirements_label := $Info/BasePanel/Requirements

var global_id: String
var requirements: Dictionary

func setup(data: Dictionary) -> void:
	title.text = data["title"]
	info.text = data["description"]
	requirements_label.text = data["text_requirements"]
	global_id = data["ending_id"]
	requirements = data["requirements"]

func set_selected(state: bool) -> void:
	if state:
		modulate = Color.AQUA
	else:
		modulate = Color.WHITE

func check_requirements() -> void:
	if requirements.has("stats"):
		for key in requirements["stats"]:
			var stat_value = requirements["stats"][key]
			if GameState.stats[key] < stat_value:
				disabled = true

func get_id() -> String:
	return global_id
