extends Node

const SAVE_PATH = "user://save.cfg"
var high_score: int = 0

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		high_score = config.get_value("stats", "high_score", 0)

func submit_score(score: int) -> void:
	if score > high_score:
		high_score = score
		var config = ConfigFile.new()
		config.set_value("stats", "high_score", high_score)
		config.save(SAVE_PATH)

func reset_score() -> void:
	high_score = 0
	var config = ConfigFile.new()
	config.set_value("stats", "high_score", 0)
	config.save(SAVE_PATH)
