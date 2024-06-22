extends Sprite2D

@export var correct_position: Vector2

@onready var collision_shape: CollisionShape2D = $Area/CollisionShape
@onready var position_text: Label = $PositionText
@onready var correct_text: Label = $CorrectText
@onready var slide_rotation: int = 0 # n = 90*

var is_dragging: bool = false
var is_hovering: bool = false
var is_correct: bool = false
var mouse_offset: Vector2 = Vector2.ZERO
var pickup_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	collision_shape.get_shape().set_size(get_texture().get_size())

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() && is_hovering):
			is_dragging = true
			mouse_offset = get_global_position() - get_global_mouse_position()
			pickup_position = get_global_position()
		elif (event.is_released()):
			is_dragging = false
			if (is_position_correct()):
				correct_text.set_text("correct")
			else:
				correct_text.set_text("incorrect")
			if (is_position_rotatable()):
				rotate_slide()
			
	if (event is InputEventMouseMotion):
		if (is_dragging):
			var new_position = get_global_mouse_position() + mouse_offset
			set_position(new_position)
			position_text.set_text(str(new_position.x) + "\n" + str(new_position.y))
			
func rotate_slide() -> void:
	slide_rotation = (slide_rotation + 1) % 4
	set_rotation_degrees(90 * slide_rotation)

func is_position_correct() -> bool:
	return get_global_position().distance_to(correct_position) <= Global.slide_minimum_correct_distance
	
func is_position_rotatable() -> bool:
	return get_global_position().distance_to(pickup_position) <= Global.slide_minimum_rotate_distance
			
func _on_mouse_entered() -> void:
	is_hovering = true

func _on_mouse_exited() -> void:
	is_hovering = false
