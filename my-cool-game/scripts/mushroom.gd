extends Area2D

@export var bounce_strength := -330.0
@onready var sprite: Sprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("bounce"):
		return
	if body.velocity.y <= 0:
		return
	body.bounce(bounce_strength)
	var tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.3, 0.6), 0.06)
	tween.tween_property(sprite, "scale", Vector2.ONE, 0.15)
