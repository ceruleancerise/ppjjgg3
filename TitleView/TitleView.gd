extends View

func _input(event: InputEvent) -> void:
	if (event is InputEventKey):
		if (event.is_action_pressed("ui_accept")):
			s_transition_to_view.emit(Global.view_ids.CUTSCENE, Global.test_cutscene)
