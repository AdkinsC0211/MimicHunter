extends RigidBody2D


func _ready() -> void:
	pass


func _on_bonked(area: Area2D) -> void:
	if area.is_in_group("PLAYER_ATTACK") and area.monitoring:
		$BonkNoise.play()
		area.get_parent().hurt(20)

