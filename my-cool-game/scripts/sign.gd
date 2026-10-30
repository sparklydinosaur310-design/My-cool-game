extends Area2D

@export_multiline var message := "This is the end of My Cool Game"
@export var prompt_text := 'Press "E" to read the sign'
@export var ends_game := false

var player_near := false
var reading := false

@onready var prompt: Label = $CanvasLayer/Prompt
@onready var message_label: Label = $CanvasLayer/Message

func _ready() -> void:
	prompt.text = prompt_text
	prompt.visible = false
	message_label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("bounce"):
		player_near = true
		prompt.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("bounce"):
		player_near = false
		reading = false
		prompt.visible = false
		message_label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if not player_near or not event.is_action_pressed("interact"):
		return
	if ends_game:
		finish_game()
		return
	reading = not reading
	message_label.text = message
	message_label.visible = reading
	prompt.visible = not reading

func finish_game() -> void:
	player_near = false
	var gm = get_tree().get_first_node_in_group("game_manager")
	if gm:
		Run.bank(gm.score)
	SaveData.submit_score(Run.banked)
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
