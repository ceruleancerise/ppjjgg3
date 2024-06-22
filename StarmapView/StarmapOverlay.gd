class_name StarmapOverlay extends Control

signal s_overlay_closed()

@onready var overlay_image: TextureRect = $OverlayImage
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var close_button: TextureButton = $CloseButton

func set_prop(quadrant: int) -> void:
	var image: Texture2D = null
	if (quadrant == 1):
		image = load("res://assets/starmap/journal.png")
	elif (quadrant == 2):
		image = load("res://assets/starmap/brochure.png")
	elif (quadrant == 3):
		image = load("res://assets/starmap/photo.png")
	elif (quadrant == 4):
		image = load("res://assets/starmap/ticket.png")
	
	overlay_image.set_texture(image)

func _on_close_button_pressed() -> void:
	s_overlay_closed.emit()
	animation_player.play("exit")

func _on_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "exit"): self.queue_free()
