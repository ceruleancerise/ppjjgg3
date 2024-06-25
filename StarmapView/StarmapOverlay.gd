class_name StarmapOverlay extends Control

signal s_overlay_closed()

@onready var p_CutsceneView = preload("res://CutsceneView/CutsceneView.tscn")

@onready var cutscene_container: Control = $CutsceneContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
	
func set_cutscene(quadrant: int) -> void:
	var cutscene: CutsceneView = p_CutsceneView.instantiate()
	var cutscene_data: Array[CutsceneFrameData]
	
	if (quadrant == 1):
		cutscene_data = Cutscenes.JOURNAL
	elif (quadrant == 2):
		cutscene_data = Cutscenes.BROCHURE
	elif (quadrant == 3):
		cutscene_data = Cutscenes.PHOTO
	elif (quadrant == 4):
		cutscene_data = Cutscenes.TICKET
	elif (quadrant == 5):
		cutscene_container.set_scale(Vector2(2, 2))
		cutscene_data = Cutscenes.ENDING
	elif (quadrant == 6):
		cutscene_data = Cutscenes.LETTER
		
	if (!!cutscene_data):
		cutscene.data = { "cutscene": cutscene_data, "next_view_id": "" }
		cutscene.connect("s_cutscene_done", _on_cutscene_done)
		cutscene_container.add_child(cutscene)
	
func _on_cutscene_done() -> void:
	s_overlay_closed.emit()
	animation_player.play("exit")

func _on_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "exit"): self.queue_free()
