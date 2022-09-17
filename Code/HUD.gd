extends CanvasLayer


func _ready() -> void:
	pass

func change_ui_mimics_left(num:int)->void:
	$GUI/HBoxContainer/NumRemaining.text = str(num)
