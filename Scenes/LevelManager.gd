extends Node2D

func _ready() -> void:
	$MimicManager.level_logic = self

func on_all_mimics_dead()->void:
	get_tree().paused = true
	$Menus/NextLevel.show()

	
