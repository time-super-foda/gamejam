extends Control

var bonga: float

func _ready() -> void:
	print("GUI ready")
	bonga = global_position.y


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Scene.tscn")

func _on_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file("res://creditScene.tscn")

func _on_back_principal_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://new_splash.tscn")
