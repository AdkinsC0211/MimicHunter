extends KinematicBody2D
#common variable
export var health: int = 1
export var speed: float = 20
var detection = false
var move_vec = Vector2.ZERO
var player = null
onready var timer = $Timer
var speed_time = 1

func _ready() -> void:
	add_to_group("MIMIC")


func _physics_process(delta):
	if speed_time >= 0:
		speed = 40
		speed_time -= delta
	else:
		speed = 20
	if detection == true: #check if in range of player's vision
		move_vec = Vector2.ZERO
	move_and_slide(move_vec * speed)



func _on_Area2D_body_entered(body):
	if body.is_in_group("PLAYER"):
		player = body
		detection = true
		$bullet_spawner.firing = false
	if body.is_in_group("ITEM"):
		$Sprite.set_texture(body.get_node("Sprite").get_texture())
		rotation_degrees = body.rotation_degrees


func _on_Area2D_body_exited(body):
	if body.is_in_group("PLAYER"):
		move_vec = (transform.origin - player.transform.origin).normalized()
		detection = false
		$bullet_spawner.firing = true
		speed_time = 1


func _on_Timer_timeout():
	move_vec = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()#pick a random direction to move off-screen
	timer.wait_time = 5
	timer.start()

func get_bonked(damage: int) ->void:
	health-=damage
	if health < 1:
		die()

func die()->void:
	queue_free()
