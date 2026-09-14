extends Button

@onready var title := $Info/BasePanel/Title
@onready var info := $Info/BasePanel/Info
@onready var requirements := $Info/BasePanel/Requirements

func setup(data: Dictionary):
	title.text = data["title"]
	info.text = data["description"]
	requirements.text = data["text_requirements"]
