extends Control

@onready var map: TextureRect = $Map
@onready var camera: Camera2D = $Camera
@onready var props: Control = $Props

var p_StarmapOverlay = preload("res://StarmapView/StarmapOverlay.tscn")

var map_size: Vector2
var map_size_4th: Vector2
var overlay: StarmapOverlay

func _ready() -> void:
	map_size = map.get_texture().get_size()
	map_size_4th = map_size / 4
	set_quadrant(1)
	
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
	overlay.set_prop(quadrant)
	overlay.connect("s_overlay_closed", display_props)
	
	display_props(false)

func _on_prop_1_pressed() -> void:
	display_overlay(1)

func _on_prop_2_pressed() -> void:
	display_overlay(2)

func _on_prop_3_pressed() -> void:
	display_overlay(3)

func _on_prop_4_pressed() -> void:
	display_overlay(4)
