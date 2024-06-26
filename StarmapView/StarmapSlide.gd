class_name StarmapSlide extends Sprite2D

signal s_correct_slide(slide: StarmapSlide)

@export var correct_position: Vector2
@export var correct_rotation: int = 0
@export var quadrant: int

@onready var collision_shape: CollisionShape2D = $Area/CollisionShape
@onready var position_text: Label = $PositionText
@onready var correct_text: Label = $CorrectText
@onready var slide_rotation: int = 0 # n = 90deg
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

var is_dragging: bool = false
var is_hovering: bool = false
var is_correct: bool = false
var mouse_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	collision_shape.get_shape().set_size(get_texture().get_size())
	for i in range (Global.rng.randi() % 4):
		rotate_slide()
			
func _input(event: InputEvent) -> void:
	if (is_correct): return
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			if (event.is_pressed() && is_hovering):
				is_dragging = true
				mouse_offset = get_global_position() - get_global_mouse_position()
			elif (event.is_released()):
				is_dragging = false
				check_correctness() 
				
		if (event.button_index == MOUSE_BUTTON_RIGHT):
			if (event.is_pressed() && is_hovering):
				rotate_slide()
				check_correctness()
					
	if (event is InputEventMouseMotion):
		if (is_dragging):
			var new_position = get_global_mouse_position() + mouse_offset
			set_position(new_position)
			position_text.set_text(str(new_position.x) + "\n" + str(new_position.y))
			
	if (event is InputEventKey):
		if (event.is_action_pressed("debug_key")):
			position_text.set_visible(!position_text.visible)
			correct_text.set_visible(!correct_text.visible)
			
func check_correctness() -> void:
	var is_position_correct = (get_global_position().distance_to(correct_position) <= Global.slide_minimum_correct_distance)
	var is_rotation_correct = (correct_rotation == slide_rotation)
	
	if (correct_rotation == -1):
		correct_text.set_text("Red Herring")
	else:
		correct_text.set_text("Pos: " + str(is_position_correct) + "\nRot: " + str(is_rotation_correct))
	
	is_correct = is_position_correct && is_rotation_correct
	if (!!is_correct): 
		s_correct_slide.emit(self)
		set_modulate(Color("#ffff9b"))
		audio_player.play()

func rotate_slide() -> void:
	slide_rotation = (slide_rotation + 1) % 4
	set_rotation_degrees(90 * slide_rotation)

func _on_mouse_entered() -> void:
	is_hovering = true

func _on_mouse_exited() -> void:
	is_hovering = false
