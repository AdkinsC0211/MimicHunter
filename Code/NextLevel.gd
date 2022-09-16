extends Control

var level: int
func _ready() -> void:
	pass


func do_change_level() -> void:
	print("changing to level" + str(level+1))
	get_tree().change_scene("res://Scenes/Levels/Level" + str(level+1) + ".tscn")

func main_menu() -> void:
	print("fetching main menu")
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
