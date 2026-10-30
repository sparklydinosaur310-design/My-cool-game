extends Area2D

const LEVEL_COMPLETE = preload("res://scenes/level_complete.tscn")
var done = false

func _on_body_entered(body: Node2D) -> void:
	if done or not body.has_method("bounce"):
		return
	done = true
	var gm = get_tree().get_first_node_in_group("game_manager")
	Run.bank(gm.score)
	SaveData.submit_score(Run.banked)
	SaveData.unlock_level(mini(Run.level_index + 2, Run.LEVELS.size()))
	get_tree().current_scene.add_child(LEVEL_COMPLETE.instantiate())
