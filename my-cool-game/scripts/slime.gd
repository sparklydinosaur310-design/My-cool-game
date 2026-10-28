extends Node2D

const SPEED = 60
const MAX_HITS = 3
const STOMP_BOUNCE = -230.0
const KILL_BOUNCE = -330.0

var direction = 1
var hits = 0
var dead = false

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta

func _on_stomp_zone_body_entered(body: Node2D) -> void:
	if dead or not body.has_method("bounce"):
		return
	if body.velocity.y <= 0:
		return
	hits += 1
	if hits >= MAX_HITS:
		die(body)
	else:
		body.bounce(STOMP_BOUNCE)
		flash()

func flash() -> void:
	animated_sprite.modulate = Color(1, 0.3,0.3)
	create_tween().tween_property(animated_sprite, "modulate", Color.WHITE, 0.2)

func die(player) -> void:
	dead = true
	set_process(false)
	$Killzone.set_deferred("monitoring", false)
	$Stompzone.set_deferred("monitoring", false)
	player.bounce(KILL_BOUNCE)
	animated_sprite.stop()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(animated_sprite, "scale:y", 0.3, 0.25)
	tween.tween_property(animated_sprite, "modulate:a", 0.0, 0.25)
	tween.chain().tween_callback(queue_free)
