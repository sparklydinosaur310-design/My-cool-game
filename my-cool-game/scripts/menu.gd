extends Control

@onready var high_score_label: Label = $HighScoreLabel

func _ready() -> void:
	high_score_label.text = "Best: " + str(SaveData.high_score)

func _on_button_pressed() -> void:
	Run.new_run()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_reset_score_pressed() -> void:
	SaveData.reset_score()
	high_score_label.text = "Best: 0"
