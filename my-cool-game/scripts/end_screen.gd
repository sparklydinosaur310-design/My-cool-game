extends Control

const SCROLL_SPEED = 115.0

@onready var roll: VBoxContainer = $Roll
@onready var coins_label: Label = $Roll/CoinsLabel
@onready var slimes_label: Label = $Roll/SlimesLabel
@onready var deaths_label: Label = $Roll/DeathsLabel
@onready var time_label: Label = $Roll/TimeLabel
@onready var best_label: Label = $Roll/BestLabel
@onready var menu_button: Button = $Roll/MenuButton

var tween: Tween
var end_y := 0.0

func _ready() -> void:
	coins_label.text = "Coins picked up: %d (this run: %d)" % [SaveData.total_coins, Run.total_pickups]
	slimes_label.text = "Slimes defeated: %d (this run: %d)" % [SaveData.total_slimes, Run.slimes_killed]
	deaths_label.text = "Deaths: %d (this run: %d)" % [SaveData.total_deaths, Run.deaths]
	time_label.text = "Time played: %s (this run:%s)" % [SaveData.format_time(), Run.format_time()]
	best_label.text = "Best: " + str(SaveData.high_score)

	for child in roll.get_children():
		if child is Label:
			child.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	menu_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	menu_button.disabled = true

	var screen = get_viewport_rect().size
	roll.size.x = screen.x
	roll.position = Vector2(0, screen.y)
	await get_tree().process_frame

	var h = roll.get_combined_minimum_size().y
	if h < screen.y:
		end_y = (screen.y - h) / 2.0
	else:
		end_y = screen.y - h - 40.0

	var duration = (screen.y - end_y) / SCROLL_SPEED
	tween = create_tween()
	tween.tween_property(roll, "position:y", end_y, duration)
	tween.tween_callback(finish)

func finish() -> void:
	menu_button.disabled = false

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
