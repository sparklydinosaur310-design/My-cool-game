extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var v_box_container_2: VBoxContainer = $VBoxContainer2
@onready var v_box_container_3: VBoxContainer = $VBoxContainer3

func _on_back_pressed() -> void:
	v_box_container.visible = true
	v_box_container_2.visible = false
	v_box_container_3.visible = false

func _on_volume_pressed() -> void:
	v_box_container.visible = false
	v_box_container_2.visible = true
	v_box_container_3.visible = false

func _on_sound_effects_pressed() -> void:
	v_box_container.visible = false
	v_box_container_2.visible = false
	v_box_container_3.visible = true

var music_bus = AudioServer.get_bus_index("Music")

func _on__pressed() -> void:
	AudioServer.set_bus_mute(music_bus, true)

func _on_one_hundred_percent_pressed() -> void:
	AudioServer.set_bus_mute(music_bus, false)
	AudioServer.set_bus_volume_db(music_bus, -4.0)

func _on_two_hundred_percent_pressed() -> void:
	AudioServer.set_bus_mute(music_bus, false)
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(2.0))

func _on_back_one_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_back_three_pressed() -> void:
	v_box_container.visible = true
	v_box_container_2.visible = false
	v_box_container_3.visible = false

var sfx_bus = AudioServer.get_bus_index("SFX")

func _on_zero_percent_one_pressed() -> void:
	AudioServer.set_bus_mute(sfx_bus, true)

func _on_one_hundred_percent_o_one_pressed() -> void:
	AudioServer.set_bus_mute(sfx_bus, false)
	AudioServer.set_bus_volume_db(sfx_bus, 0.0)
