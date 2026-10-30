extends Control

const STAR_COUNT = 80

func _ready() -> void:
	var screen = get_viewport_rect().size
	for i in STAR_COUNT:
		var star = ColorRect.new()
		var s = [1, 1, 2, 2, 3].pick_random()
		star.size = Vector2(s, s)
		star.position = Vector2(randf() * screen.x, randf() * screen.y)
		star.color = Color(1, 1, 1, randf_range(0.4, 1.0))
		star.mouse_filter = Control.MOUSE_FILTER_IGNORE
		add_child(star)
		twinkle(star)

func twinkle(star: ColorRect) -> void:
	var t = create_tween().set_loops()
	t.tween_interval(randf() * 2.0)
	t.tween_property(star, "modulate:a", 0.2, randf_range(0.6, 1.6))
	t.tween_property(star, "modulate:a", 1.0, randf_range(0.6, 1.6))
