extends ViewportContainer


func _ready() -> void:
	pass


func change_ui_health(health_percent) -> void:
	print("ui is active")
	$Viewport/TextureProgress.value = health_percent * 100
