extends Node

var slide_minimum_rotate_distance: int = 15
var slide_minimum_correct_distance: int = 75

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
