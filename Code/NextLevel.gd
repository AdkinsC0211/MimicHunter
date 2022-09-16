extends Control


func _ready() -> void:
	pass


func do_change_level(next_level_num: int) -> void:
	get_tree().change_scene("res://Scenes/Levels/Level" + str(next_level_num) + ".tscn")

func main_menu() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
