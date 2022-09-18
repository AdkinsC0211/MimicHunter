extends Control


func _ready():
	pass # Replace with function body.

func _on_BackToMenu_pressed():
	get_tree().change_scene(("res://Scenes/Menus/MainMenu.tscn"))
