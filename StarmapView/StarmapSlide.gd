extends Area2D

@export var slide_texture: Texture2D
@export var correct_position: Vector2

@onready var slide_sprite: Sprite2D = $SlideSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var position_text: Label = $PositionText
@onready var correct_text: Label = $CorrectText

var is_dragging: bool = false
var is_hovering: bool = false
var is_correct: bool = false
var mouse_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	slide_sprite.set_texture(slide_texture)
	collision_shape.get_shape().set_size(slide_texture.get_size())

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() && is_hovering):
			is_dragging = true
			mouse_offset = get_global_position() - get_global_mouse_position()
		elif (event.is_released()):
			is_dragging = false
			if (is_position_correct()):
				correct_text.set_text("correct")
			else:
				correct_text.set_text("incorrect")
			
	if (event is InputEventMouseMotion):
		if (is_dragging):
			var position = get_global_mouse_position()
			position_text.set_text(str(position.x) + "\n" + str(position.y))
			
func is_position_correct() -> bool:
	print(get_global_position().distance_to(correct_position))
	return get_global_position().distance_to(correct_position) <= Global.slide_minimum_correct_distance
			
func _on_mouse_entered() -> void:
	is_hovering = true

func _on_mouse_exited() -> void:
	is_hovering = false
