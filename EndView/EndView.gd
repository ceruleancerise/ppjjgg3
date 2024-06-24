class_name EndView extends View

func _on_advance_button_pressed() -> void:
	s_transition_to_view.emit(Views.ids.TITLE, {})
