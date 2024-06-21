class_name CutsceneFrame extends Control

@export var data: CutsceneFrameData

@onready var cutscene_image: TextureRect = $CutsceneImage
@onready var cutscene_title: Label = $UI/CutsceneText/Title
@onready var cutscene_description: Label = $UI/CutsceneText/Description

func _ready() -> void:
	cutscene_image.set_texture(data.image)
	cutscene_title.set_text(data.title)
	cutscene_description.set_text(data.description)

func set_data(new_data: CutsceneFrameData) -> void:
	data = new_data
