extends KinematicBody2D


#common variable
export var health: int = 1
export var speed: float = 20
var move_vec = Vector2.ZERO
var player = null
var bonked: bool = false
onready var timer = $Timer
var speed_time = 1
var frozen: bool = false

#mimics are managed by a parent mimic manager node
onready var manager: Node = get_parent()

func _ready() -> void:
	add_to_group("MIMIC")

	

func _physics_process(delta):
	if frozen: return
	
	if speed_time >= 0:
		speed = 40
		speed_time -= delta
	else:
		speed = 20
	move_and_slide(move_vec * speed)



func _on_Area2D_body_entered(body):
	if body.is_in_group("ITEM") and not frozen:
		$Sprite.set_texture(body.get_node("Sprite").get_texture())
		rotation_degrees = body.rotation_degrees
	

func _on_Timer_timeout():
	move_vec = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()#pick a random direction to move off-screen
	timer.wait_time = 5
	timer.start()

func get_bonked(damage: int) ->void:
	health-=damage
	if health < 1:
		die()

func die()->void:
	manager.decrement_children()
	queue_free()


func _on_SightArea_body_exited(body: Node) -> void:
	#if body.is_in_group("PLAYER"):
	pass

		
func freeze():
	frozen=true
	#move_vec = (transform.origin - player.transform.origin).normalized()
	$bullet_spawner.firing = false
	speed_time = 1
func unfreeze():
	frozen=false
	$bullet_spawner.firing = true


func _on_CammoRange_body_entered(body: Node) -> void:
	if body.is_in_group("ITEM") and not frozen:
		$Sprite.set_texture(body.get_node("Sprite").get_texture())
		rotation_degrees = body.rotation_degrees
