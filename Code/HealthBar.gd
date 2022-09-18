extends ViewportContainer


func _ready() -> void:
	pass

func change_ui_health(health) -> void:
	print(health)
	$Viewport/TextureProgress.value = health
