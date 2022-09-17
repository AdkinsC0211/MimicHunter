extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/NewGame.grab_focus()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_New_Game_pressed():
	get_tree().change_scene("res://Scenes/Levels/Tutorial.tscn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_LevelSelect_button_up() -> void:
	get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")
