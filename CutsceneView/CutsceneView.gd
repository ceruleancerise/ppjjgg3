extends Control

@onready var cutscene_image: TextureRect = $CutsceneImage
@onready var cutscene_title: Label = $CutsceneTitle
@onready var cutscene_description: Label = $CutsceneDescription

var cutscene_frames: Array[CutsceneFrame] = []
var current_cutscene_frame_index: int = -1

func _ready() -> void:
	cutscene_frames = Global.test_cutscene
	advance_cutscene()

func advance_cutscene() -> void:
	current_cutscene_frame_index += 1
	var frame = cutscene_frames[current_cutscene_frame_index]
	cutscene_image.set_texture(frame.image)
	cutscene_title.set_text(frame.title)
	cutscene_description.set_text(frame.description)
