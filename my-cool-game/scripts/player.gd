extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -270.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_bounce_msec := -1000

func bounce(strength: float) -> void:
	velocity.y = strength
	last_bounce_msec = Time.get_ticks_msec()

func just_bounced() -> bool:
	return Time.get_ticks_msec() - last_bounce_msec < 150

var invincible := false

func hurt() -> void:
	invincible = true
	velocity.y = -180.0
	var tween = create_tween().set_loops(6)
	tween.tween_property(animated_sprite, "modulate:a", 0.3, 0.1)
	tween.tween_property(animated_sprite, "modulate:a", 1.0, 0.1)
	await get_tree().create_timer(1.2).timeout
	invincible = false
	animated_sprite.modulate.a = 1.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the imput direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
