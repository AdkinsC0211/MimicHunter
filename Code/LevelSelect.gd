extends CanvasLayer


func _ready() -> void:
	pass


func _on_MainMenu_button_up() -> void:
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")


func _on_Level0_button_up() -> void:
	get_tree().change_scene("res://Scenes/Levels/Tutorial.tscn")


func _on_Level1_button_up() -> void:
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_Level2_button_up() -> void:
	get_tree().change_scene("res://Scenes/Levels/Level2.tscn")


func _on_Level3_button_up() -> void:
	get_tree().change_scene("res://Scenes/Levels/Level3.tscn")
