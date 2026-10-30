extends Node

const SAVE_PATH = "user://save.cfg"

var high_score: int = 0
var checkpoints: bool = false
var levels_unlocked: int = 1

#Lifetime stats
var total_coins: int = 0
var total_deaths: int = 0
var total_slimes: int = 0
var total_seconds: float = 0.0

var _save_timer := 0.0

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		high_score = config.get_value("stats", "high_score", 0)
		checkpoints = config.get_value("settings", "checkpoints", false)
		levels_unlocked = config.get_value("progress", "levels_unlocked", 1)
		total_coins = config.get_value("lifetime", "coins", 0)
		total_deaths = config.get_value("lifetime", "deaths", 0)
		total_slimes = config.get_value("lifetime", "slimes", 0)
		total_seconds = config.get_value("lifetime", "seconds", 0.0)

func save_all() -> void:
	var config = ConfigFile.new()
	config.set_value("stats", "high_score", high_score)
	config.set_value("settings", "checkpoints", checkpoints)
	config.set_value("progress", "levels_unlocked", levels_unlocked)
	config.set_value("lifetime", "coins", total_coins)
	config.set_value("lifetime", "deaths", total_deaths)
	config.set_value("lifetime", "slimes", total_slimes)
	config.set_value("lifetime", "seconds", total_seconds)
	config.save(SAVE_PATH)

func _process(delta: float) -> void:
	total_seconds += delta
	_save_timer += delta
	if _save_timer >= 15.0:
		_save_timer = 0.0
		save_all()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_all()

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

func unlock_level(count: int) -> void:
	if count > levels_unlocked:
		levels_unlocked = count
		save_all()

func add_coin() -> void:
	total_coins += 1
	save_all()

func add_death() -> void:
	total_deaths += 1
	save_all()

func add_slime() -> void:
	total_slimes += 1
	save_all()

func format_time() -> String:
	var s := int(total_seconds)
	return "%d:%02d:%02d" % [s / 3600, (s % 3600) / 60, s % 60]
