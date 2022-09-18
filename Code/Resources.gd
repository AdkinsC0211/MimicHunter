extends Control


func _ready():
	$VBoxContainer/BackToMenu.grab_focus()

func _on_BackToMenu_pressed():
	get_tree().change_scene(("res://Scenes/Menus/MainMenu.tscn"))


func _on_Credits_pressed():
	get_tree().change_scene(("res://Scenes/Menus/Credits.tscn"))


func _on_BackToMenu_button_down():
	get_tree().change_scene(("res://Scenes/Menus/MainMenu.tscn"))


func _on_Credits_button_down():
	get_tree().change_scene(("res://Scenes/Menus/Credits.tscn"))
