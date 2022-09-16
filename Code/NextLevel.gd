extends Control


func _ready() -> void:
	pass


func next_level() -> void:
	get_tree().change_scene("res://Scenes/Level2.tscn")


func main_menu() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
