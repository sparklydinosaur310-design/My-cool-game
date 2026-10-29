extends Node

signal changed
const MAX_HEARTS = 3
var hearts = MAX_HEARTS

func lose(amount := 1) -> void:
	hearts = max(hearts - amount, 0)
	changed.emit()

func reset() -> void:
	hearts = MAX_HEARTS
	changed.emit()
