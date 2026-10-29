extends Node

var score = 0

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	update_label()

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
	SaveData.submit_score(score)

func update_label() -> void:
	score_label.text = "You collected " +str(Run.banked + score) + " coins."
