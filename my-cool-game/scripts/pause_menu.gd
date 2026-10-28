extends Control

func _ready() -> void:
	visible = false
	print("pause menu ready")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		print("key:", event.keycode)
		if event.keycode == KEY_ESCAPE:
			var is_paused = not get_tree().paused
			get_tree().paused = is_paused
			visible = is_paused
			get_viewport().set_input_as_handled()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree(). change_scene_to_file("res://scenes/menu.tscn")
