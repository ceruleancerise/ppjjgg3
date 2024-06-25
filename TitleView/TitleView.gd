class_name TitleView extends View

func _on_advance_button_pressed() -> void:
	s_transition_to_view.emit(Views.ids.CUTSCENE, {
		"cutscene": Cutscenes.COMIC,
		"next_view_id": Views.ids.STARMAP
	})
