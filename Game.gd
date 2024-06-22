extends Node

var current_view: View = null

func _ready() -> void:
	transition_to_view(Views.ids.TITLE, null)

func transition_to_view(view_id: String, data: Variant) -> void:
	var new_view: View = Views[view_id].instantiate()
	new_view.data = data
	add_child(new_view)
	
	new_view.connect("s_transition_to_view", transition_to_view)
	if (!!current_view): remove_child(current_view)
	current_view = new_view
