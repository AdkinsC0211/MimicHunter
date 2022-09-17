extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_Yes_pressed():
	get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")


func _on_No_pressed():
	get_tree().quit()
