extends Node2D


func _ready() -> void:
	pass

func on_all_mimics_dead()->void:
	get_tree().change_scene("res://Scenes/NextLevel.tscn")
