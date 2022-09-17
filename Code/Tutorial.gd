extends Control


func _ready() -> void:
	$WASD.show()

func _process(delta: float) -> void:
	if $"../MimicManager".get_child_count()==0:
		$WASD.hide()
		$Item.hide()
		$Mimic.hide()


func _on_item_tagged(area: Area2D) -> void:
	if area.is_in_group("PLAYER_ATTACK") and area.monitoring == true:
		print("bawls")
		$Item.hide()
		$Mimic.show()


func _on_Player_exited(body: Node) -> void:
	if body.is_in_group("PLAYER"):
		$WASD.hide()
		$Item.show()
