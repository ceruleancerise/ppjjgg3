extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var current_view_container: Control = $CurrentViewContainer
@onready var previous_view_container: Control = $PreviousViewContainer

var current_view: View = null
var previous_view: View = null

func _ready() -> void:
	transition_to_view(Views.ids.TITLE, null)

func transition_to_view(view_id: String, data: Variant) -> void:
	if (!!previous_view): previous_view.queue_free()
	if (!!current_view): current_view.reparent(previous_view_container)
	previous_view = current_view
	
	current_view = Views[view_id].instantiate()
	current_view.data = data
	current_view.connect("s_transition_to_view", transition_to_view)
	current_view_container.set_modulate(Color(1, 1, 1, 0))
	current_view_container.add_child(current_view)
	
	animation_player.play("crossfade")

func _on_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "crossfade"):
		if (!!previous_view): previous_view.queue_free()
