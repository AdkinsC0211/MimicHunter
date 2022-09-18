extends Control

var level: int
func _ready() -> void:
	$NextLevelRect/VBoxContainer/NextLevel.grab_focus()

func _process(delta: float) -> void:
	if visible and Input.is_action_just_pressed("ui_accept"):
		do_level_change()

func main_menu() -> void:
	print("fetching main menu")
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")


func do_level_change() -> void:
	print("changing to level" + str(level+1))
	get_tree().change_scene("res://Scenes/Levels/Level" + str(level+1) + ".tscn")

