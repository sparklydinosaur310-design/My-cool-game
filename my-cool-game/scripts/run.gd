extends Node

const LEVELS = [
	"res://scenes/game.tscn",
	"res://scenes/level_2.tscn",
]

var level_index = 0
var banked = 0
var respawn_pos := Vector2.ZERO
var respawn_valid := false
var total_pickups = 0
var deaths = 0
var start_msec = 0
var slimes_killed = 0

func new_run() -> void:
	level_index = 0
	banked = 0
	clear_respawn()
	Health.reset()
	total_pickups = 0
	deaths = 0
	start_msec = Time.get_ticks_msec()
	slimes_killed = 0

func bank(coins: int) -> void:
	banked += coins

func has_next_level() -> bool:
	return level_index + 1 < LEVELS.size()

func next_level() -> void:
	level_index += 1
	clear_respawn()
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func save_respawn(player: Node) -> void:
	if SaveData.checkpoints and player.has_method("get_respawn_point"):
		respawn_pos = player.get_respawn_point()
		respawn_valid = true

func clear_respawn() -> void:
	respawn_valid = false

func start_level(index: int) -> void:
	new_run()
	level_index = index
	get_tree().change_scene_to_file(LEVELS[index])

func format_time() -> String:
	var secs = (Time.get_ticks_msec() - start_msec) / 1000
	return "%d:%02d" % [secs / 60, secs % 60]
