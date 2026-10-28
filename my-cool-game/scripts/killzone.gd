extends Area2D

@export var stompable := false
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if stompable:
		await get_tree().physics_frame
		if body.has_method("just_bounced") and body.just_bounced():
			return
	print ("You Died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
