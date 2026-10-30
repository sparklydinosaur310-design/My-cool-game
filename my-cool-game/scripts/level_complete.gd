extends CanvasLayer

@onready var title: Label = $VBoxContainer/Title
@onready var coins_label: Label = $VBoxContainer/CoinsLabel
@onready var next_button: Button = $VBoxContainer/NextButton

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title.text = "Level Complete!"
	coins_label.text = "Coins so far: " +str(Run.banked)
	if not Run.has_next_level():
		title.text = "You Win!"
		next_button.text = "Continue"

func _on_next_button_pressed() -> void:
	get_tree().paused = false
	if Run.has_next_level():
		Run.next_level()
	else:
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
