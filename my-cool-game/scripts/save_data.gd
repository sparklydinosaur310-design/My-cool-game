extends Node

const SAVE_PATH = "user://save.cfg"
var high_score: int = 0
var checkpoints: bool = false

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		high_score = config.get_value("stats", "high_score", 0)
		checkpoints = config.get_value("settings", "checkpoints", false)

func save_all() -> void:
	var config = ConfigFile.new()
	config.set_value("stats", "high_score", high_score)
	config.set_value("settings", "checkpoints", checkpoints)
	config.save(SAVE_PATH)

func submit_score(score: int) -> void:
	if score > high_score:
		high_score = score
		save_all()

func reset_score() -> void:
	high_score = 0
	save_all()

func set_checkpoints(value: bool) -> void:
	checkpoints = value
	save_all()
