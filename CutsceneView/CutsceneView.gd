class_name CutsceneView extends View

signal s_cutscene_done()

@onready var previous_frame_container: Control = $PreviousFrameContainer
@onready var current_frame_container: Control = $CurrentFrameContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var advance_button: TextureButton = $AdvanceButton

var p_CutsceneFrame = preload("res://CutsceneView/CutsceneFrame.tscn")

var data_array: Array[CutsceneFrameData]
var data_array_index: int = -1

var current_frame: CutsceneFrame
var previous_frame: CutsceneFrame
var is_transitioning: bool = true

var next_view_id: String

func _ready() -> void:
	if (!!data): 
		load_frame_data(data.cutscene)
		next_view_id = data.next_view_id

func load_frame_data(new_data_array: Array[CutsceneFrameData]):
	data_array = new_data_array
	data_array_index = -1
	advance_frame()

func advance_frame():
	if (data_array_index >= data_array.size() - 1): 
		end_cutscene()
		return
		
	data_array_index += 1
	
	if (!!current_frame):
		current_frame.reparent(previous_frame_container)
	previous_frame = current_frame
	
	current_frame = p_CutsceneFrame.instantiate()
	var new_data = data_array[data_array_index]
	current_frame.set_data(new_data)
	current_frame_container.set_modulate(Color(1, 1, 1, 0))
	current_frame_container.add_child(current_frame)

	is_transitioning = true
	animation_player.play("frame_crossfade")
	
func end_cutscene() -> void:
	s_cutscene_done.emit()
	if (!!next_view_id):
		s_transition_to_view.emit(next_view_id, {})

func _on_advance_button_pressed() -> void:
	if (is_transitioning): return
	advance_frame()

func _on_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "frame_crossfade"):
		is_transitioning = false
