extends Node

const LEVELS = [
	"res://scenes/game.tscn",
	"res://scenes/level_2.tscn",
]

var level_index = 0
var banked = 0

func new_run() -> void:
	level_index = 0
	banked = 0
	Health.reset()

func bank(coins: int) -> void:
	banked += coins

func has_next_level() -> bool:
	return level_index + 1 < LEVELS.size()

func next_level() -> void:
	level_index += 1
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
