extends Area2D

@export_multiline var message := "This is the end of My Cool Game"

var player_near := false
var reading := false

@onready var prompt: Label = $CanvasLayer/Prompt
@onready var message_label: Label = $CanvasLayer/Message

func _ready() -> void:
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
	if player_near and event.is_action_pressed("interact"):
		reading = not reading
		message_label.text = message
		message_label.visible = reading
		prompt.visible = not reading
