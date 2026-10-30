extends Control

@onready var credits: Label = $Credits
@onready var stats: VBoxContainer = $Stats
@onready var coins_label: Label = $Stats/CoinsLabel
@onready var deaths_label: Label = $Stats/DeathsLabel
@onready var time_label: Label = $Stats/TimeLabel

var tween: Tween

func _ready() -> void:
	stats.visible = false
	coins_label.text = "Coins picked up: " + str(Run.total_pickups)
	deaths_label.text = "Deaths: " + str(Run.deaths)
	time_label.text = "Time: " + Run.format_time()
	await get_tree().process_frame
	credits.position.y = size.y
	tween = create_tween()
	tween.tween_property(credits, "position:y", -credits.size.y, 12.0)
	tween.tween_callback(show_stats)

func show_stats() -> void:
	credits.visible = false
	stats.visible = true
	stats.modulate.a = 0.0
	create_tween().tween_property(stats, "modulate:a", 1.0, 1.0)

func _unhandled_input(event: InputEvent) -> void:
	if stats.visible:
		return
	if event.is_action("ui_accept") or (event is InputEventMouseButton and event.pressed):
		tween.kill()
		show_stats()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
