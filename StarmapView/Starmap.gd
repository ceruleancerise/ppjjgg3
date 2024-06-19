extends Node2D

@onready var map: Sprite2D = $Map
@onready var camera: Camera2D = $Camera

var map_size: Vector2
var map_size_4th: Vector2

func _ready() -> void:
	map_size = map.get_texture().get_size()
	map_size_4th = map_size / 4
	set_camera_to_quadrant(1)
	
func _input(event: InputEvent) -> void:
	if (event is InputEventKey):
		if (event.is_action_pressed("quad_1")):
			set_camera_to_quadrant(1)
		elif (event.is_action_pressed("quad_2")):
			set_camera_to_quadrant(2)
		elif (event.is_action_pressed("quad_3")):
			set_camera_to_quadrant(3)
		elif (event.is_action_pressed("quad_4")):
			set_camera_to_quadrant(4)
			
# 1 = TOP LEFT / 2 = TOP RIGHT / 3 = BOTTOM LEFT / 4 = BOTTOM RIGHT
func set_camera_to_quadrant(corner: int) -> void:
	if (corner == 1):
		camera.set_global_position(Vector2(-map_size_4th.x, -map_size_4th.y))
	elif (corner == 2):
		camera.set_global_position(Vector2( map_size_4th.x, -map_size_4th.y))
	elif (corner == 3):
		camera.set_global_position(Vector2(-map_size_4th.x,  map_size_4th.y))
	elif (corner == 4):
		camera.set_global_position(Vector2( map_size_4th.x,  map_size_4th.y))
