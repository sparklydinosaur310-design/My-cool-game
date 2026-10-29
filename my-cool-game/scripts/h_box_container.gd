extends HBoxContainer

const FULL = preload("res://assets/sprites/db84d775-14b7-492f-acfe-3fd3d2432ebd.png")
const EMPTY = preload("res://assets/sprites/61aa8d11-6a34-43a2-ac2d-7c1fc1d78137.png")

func _ready() -> void:
	Health.changed.connect(refresh)
	refresh()

func refresh() -> void:
	for i in get_child_count():
		get_child(i).texture = FULL if i < Health.hearts else EMPTY
