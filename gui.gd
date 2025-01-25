extends Control

func _ready() -> void:
	print("GUI ready")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Main_Scene.tscn")


func _on_leaderboard_pressed() -> void:
	# add Leaderboard system screen
	get_tree().change_scene_to_file("")
