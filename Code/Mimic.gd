extends RigidBody2D
#common variable
export var health: int = 1
export var speed: int = 1

func _ready() -> void:
	add_to_group("MIMIC")

func get_bonked(damage: int) ->void:
	health-=damage
	if health < 1:
		die()
		
func die()->void:
	queue_free()
