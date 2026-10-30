extends Control

@onready var high_score_label: Label = $HighScoreLabel
@onready var checkpoint_toggle: CheckButton = $VBoxContainer/CheckpointToggle
@onready var level_select: Control = $LevelSelect

func _ready() -> void:
	high_score_label.text = "Best: " + str(SaveData.high_score)
	checkpoint_toggle.set_pressed_no_signal(SaveData.checkpoints)

func _on_button_pressed() -> void:
	if SaveData.levels_unlocked > 1:
		level_select.visible = true
	else:
		Run.start_level(0)

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_quit_pressed() -> void:
	SaveData.save_all()
	get_tree().quit()


func _on_reset_score_pressed() -> void:
	SaveData.reset_score()
	high_score_label.text = "Best: 0"

func _on_checkpoint_toggle_toggled(toggled_on: bool) -> void:
	SaveData.set_checkpoints(toggled_on)

func _on_level_one_pressed() -> void:
	Run.start_level(0)

func _on_level_two_pressed() -> void:
	Run.start_level(1)

func _on_back_pressed() -> void:
	level_select.visible = false
