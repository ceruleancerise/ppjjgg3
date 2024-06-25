class_name StarmapView extends View

func _on_game_over() -> void:
	s_transition_to_view.emit(Views.ids.END, {})
