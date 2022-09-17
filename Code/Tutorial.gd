extends Control

var first_mimic_killed: bool = false
func _ready() -> void:
	$WASD.show()

func _process(delta: float) -> void:
	if $"../MimicManager".get_child_count() < 2 and not first_mimic_killed:
		first_mimic_killed = true
		$WASD.hide()
		$Item.hide()
		$Mimic.hide()
		$OffScreen.show()


func _on_item_tagged(area: Area2D) -> void:
	if area.is_in_group("PLAYER_ATTACK") and area.monitoring == true:
		print("bawls")
		$Item.hide()
		$Mimic.show()


func _on_Player_exited(body: Node) -> void:
	if body.is_in_group("PLAYER"):
		$WASD.hide()
		$Item.show()


func _on_Player_body_entered(body: Node) -> void:
	$OffScreen.hide()
	$Kill.show()
	
