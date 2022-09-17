extends ViewportContainer


func _ready() -> void:
	pass

func change_ui_health(health) -> void:
	$Viewport/TextureProgress.value = health * 100
