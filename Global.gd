extends Node

var slide_minimum_correct_distance: int = 50

var test_cutscene: Array[CutsceneFrameData] = [
	preload("res://CutsceneView/cutscene_frame_data/Test.tres"),
	preload("res://CutsceneView/cutscene_frame_data/Test2.tres"),
	preload("res://CutsceneView/cutscene_frame_data/Test.tres"),
	preload("res://CutsceneView/cutscene_frame_data/Test2.tres"),
	preload("res://CutsceneView/cutscene_frame_data/Test.tres"),
	preload("res://CutsceneView/cutscene_frame_data/Test2.tres"),
]

var view_ids = {
	TITLE = "TITLE",
	CUTSCENE = "CUTSCENE",
	STARMAP = "STARMAP",
	END = "END"
}

var views = {
	TITLE = preload("res://TitleView/TitleView.tscn"),
	CUTSCENE = preload("res://CutsceneView/CutsceneView.tscn"),
	STARMAP = preload("res://StarmapView/StarmapView.tscn")
}
