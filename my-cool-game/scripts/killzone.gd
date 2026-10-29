extends Area2D

@export var stompable := false
@export var pit := false
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if stompable:
		await get_tree().physics_frame
		if body.has_method("just_bounced") and body.just_bounced():
			return
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	if not pit and body.get("invincible"):
		return
	Health.lose(1)
	if stompable and Health.hearts > 0:
		body.hurt()
		return
	Run.save_respawn(body)

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	if Health.hearts <= 0:
		Run.clear_respawn()
		Health.reset()
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	else:
		get_tree().reload_current_scene()
