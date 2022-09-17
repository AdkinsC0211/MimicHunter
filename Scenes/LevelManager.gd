extends Node2D

export var level: int = -1
func _ready() -> void:
	assert(level != -1, "ERROR: You must specify the level on the level manager")
	get_tree().paused = false
	$MimicManager.level_logic = self
	$Menus/NextLevel.level = level
func on_all_mimics_dead()->void:
	print("on all mimics dead called")
	get_tree().paused = true
	$Menus/NextLevel.show()

	


func _on_Player_update_ui_health(health) -> void:
	pass # Replace with function body.

