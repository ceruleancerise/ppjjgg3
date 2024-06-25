extends Control

signal s_game_over()

@onready var map: TextureRect = $Map
@onready var camera: Camera2D = $Camera
@onready var props: Control = $Props
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var intro_letter: TextureButton = $IntroLetter
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

@onready var quad_1_slides: Array[StarmapSlide] = [
	$Slides/Quad1Slides/Slide1,
	$Slides/Quad1Slides/Slide2
]
@onready var quad_2_slides: Array[StarmapSlide] = [
	$Slides/Quad2Slides/Slide1,
	$Slides/Quad2Slides/Slide2
]
@onready var quad_3_slides: Array[StarmapSlide] = [
	$Slides/Quad3Slides/Slide1, 
	$Slides/Quad3Slides/Slide2, 
	$Slides/Quad3Slides/Slide3
]
@onready var quad_4_slides: Array[StarmapSlide] = [
	$Slides/Quad4Slides/Slide1, 
	$Slides/Quad4Slides/Slide2, 
	$Slides/Quad4Slides/Slide3
]
@onready var slides: Array[Array] = [[], quad_1_slides, quad_2_slides, quad_3_slides, quad_4_slides]

var p_StarmapOverlay = preload("res://StarmapView/StarmapOverlay.tscn")

var map_size: Vector2
var map_size_4th: Vector2
var overlay: StarmapOverlay

func _ready() -> void:
	map_size = map.get_texture().get_size()
	map_size_4th = map_size / 4
	set_quadrant(1)
	
	for slide: StarmapSlide in quad_1_slides:
		slide.connect("s_correct_slide", check_quadrant_completion)
	for slide: StarmapSlide in quad_2_slides:
		slide.connect("s_correct_slide", check_quadrant_completion)
	for slide: StarmapSlide in quad_3_slides:
		slide.connect("s_correct_slide", check_quadrant_completion)
	for slide: StarmapSlide in quad_4_slides:
		slide.connect("s_correct_slide", check_quadrant_completion)
	
func _input(event: InputEvent) -> void:
	if (event is InputEventKey):
		if (event.is_action_pressed("quad_1")):
			set_quadrant(1)
		elif (event.is_action_pressed("quad_2")):
			set_quadrant(2)
		elif (event.is_action_pressed("quad_3")):
			set_quadrant(3)
		elif (event.is_action_pressed("quad_4")):
			set_quadrant(4)
		elif (event.is_action_pressed("ending")):
			play_ending()
			
func check_quadrant_completion(selected_slide: StarmapSlide) -> void:
	var quadrant = selected_slide.quadrant
	var is_all_completed = true
	print("\n\nchecking quadrant: " + str(quadrant))
	for slide: StarmapSlide in slides[quadrant]:
		if (!slide.is_correct): 
			print("incorrect")
			is_all_completed = false
		else:
			print("correct")
			
	if (slides[quadrant].size() == 0):
		is_all_completed = false
	
	if (is_all_completed): 
		if (quadrant == 1):
			slides[1] = []
			animation_player.play("quad_1_complete")
			audio_player.play()
		elif (quadrant == 2):
			slides[2] = []
			animation_player.play("quad_2_complete")
			audio_player.play()
		elif (quadrant == 4):
			slides[4] = []
			animation_player.play("quad_4_complete")
			audio_player.play()
		elif (quadrant == 3):
			slides[3] = []
			animation_player.play("quad_3_complete")
			audio_player.play()

func quadrant_to_corner_position(quadrant: int) -> Vector2:
	if (quadrant == 1):
		return Vector2(0, 0)
	elif (quadrant == 2):
		return Vector2(2 * map_size_4th.x, 0)
	elif (quadrant == 3):
		return Vector2(0, 2 * map_size_4th.y)
	elif (quadrant == 4):
		return Vector2(2 * map_size_4th.x, 2 * map_size_4th.y)
	return Vector2.ZERO
			
func quadrant_to_center_position(quadrant: int) -> Vector2:
	if (quadrant == 1):
		return Vector2(map_size_4th.x, map_size_4th.y)
	elif (quadrant == 2):
		return Vector2(map_size_4th.x * 3, map_size_4th.y)
	elif (quadrant == 3):
		return Vector2(map_size_4th.x, map_size_4th.y * 3)
	elif (quadrant == 4):
		return Vector2(map_size_4th.x * 3, map_size_4th.y * 3)
	return Vector2.ZERO
			
# 1 = TOP LEFT / 2 = TOP RIGHT / 3 = BOTTOM LEFT / 4 = BOTTOM RIGHT
func set_quadrant(quadrant: int) -> void:
	camera.set_global_position(quadrant_to_center_position(quadrant))
	
func display_props(is_displayed: bool = true) -> void:
	props.set_visible(is_displayed)
		
func display_overlay(quadrant: int) -> void:
	if (!!overlay): 
		remove_child(overlay)
		overlay = null
	
	overlay = p_StarmapOverlay.instantiate()
	add_child(overlay)
	overlay.set_position(quadrant_to_corner_position(quadrant))
	overlay.set_cutscene(quadrant)
	overlay.connect("s_overlay_closed", on_overlay_closed)
	
	if (quadrant >= 1 && quadrant <= 4):
		display_props(false)
		
	if (quadrant == 5):
		overlay.connect("s_overlay_closed", play_ending_2)
	
	if (quadrant == 6):
		overlay.connect("s_overlay_closed", func(): display_overlay(1) )
		intro_letter.queue_free()
		
func on_overlay_closed() -> void:
	display_props(true)

func _on_prop_1_pressed() -> void:
	display_overlay(1)

func _on_prop_2_pressed() -> void:
	display_overlay(2)

func _on_prop_3_pressed() -> void:
	display_overlay(3)

func _on_prop_4_pressed() -> void:
	display_overlay(4)
	
func play_ending() -> void:
	set_quadrant(3)
	animation_player.play("ending")
	
func play_ending_2() -> void:
	animation_player.play("ending_2")
	
func _on_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "quad_1_complete"):
		set_quadrant(2)
		display_overlay(2)
	if (anim_name == "quad_2_complete"):
		set_quadrant(4)
		display_overlay(4)
	if (anim_name == "quad_4_complete"):
		set_quadrant(3)
		display_overlay(3)
	if (anim_name == "quad_3_complete"):
		play_ending()
	if (anim_name == "ending"):
		_on_ending_animation_finished()
	if (anim_name == "ending_2"):
		camera.queue_free()
		s_game_over.emit()

func _on_ending_animation_finished() -> void:
	display_overlay(5)

func _on_intro_letter_pressed() -> void:
	display_overlay(6)
