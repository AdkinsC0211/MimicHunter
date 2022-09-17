extends KinematicBody2D


export var speed = 85		#speed is changeable to wtv we need it to be
var attack_strength: float = 1
var max_health: float = 10
var health: float = max_health
var bonking: bool = false

var current_direction = Vector2.ZERO

signal update_ui_health(health)

var directional_map = {
	"look_left": Vector2(-1, 0),
	"look_right": Vector2(1, 0),
	"look_up": Vector2(0, -1),
	"look_down": Vector2(0, 1)}

# movement function begins
func _ready():
	$Sight/CollisionShape2D.get("shape").extents = get_viewport_rect().size*0.195
	
#it's best practice to use physics process for character movement
#it gives you access to functions for the built in physics system
func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
		#current_direction = Vector2(1, 0)
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
		#current_direction = Vector2(-1, 0)
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
		#current_direction = Vector2(0, 1)
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
		#current_direction = Vector2(0, -1)
	# this direction check method is fine, but I wanted to try
	#Binding of Isaac style 
	
#	# checking for a diagonal direction
#	if velocity.x > 0 and velocity.y < 0:
#		current_direction = Vector2(1, -1)
#	if velocity.x < 0 and velocity.y < 0:
#		current_direction = Vector2(-1, -1)
#	if velocity.x > 0 and velocity.y > 0:
#		current_direction = Vector2(1, 1)
#	if velocity.x < 0 and velocity.y > 0:
#		current_direction = Vector2(-1, 1)
		
		
	#binding of Isaac style direction logic
	#	# checking for a diagonal direction
	for dir in directional_map:
		if Input.is_action_just_pressed(dir):
			current_direction = directional_map[dir]
			if not bonking:
				bonk(current_direction)
			break


	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	move_and_slide(velocity)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "WALK"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y < 0:
		$AnimatedSprite.animation = "WALKUP"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = false
	elif velocity.y > 0:
		$AnimatedSprite.animation = "WALKDOWN"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = false

# collision begins
func _on_Player_body_entered(body):
	#insert corresponding action for player getting hit such as damaged health
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func bonk(direction: Vector2)->void:
	#test if object is a mimic 
	#as if delivering accurate and specific bonk
	#just to the mimic right in front of you
	
	var offset: Vector2 = direction * 15 # this is seperate in case we change factor
	var attack_box = $AttackBox
	var attack_sprite = $AttackSprite
	bonking=true
	$BonkTimer.start()
	attack_box.position = offset
	attack_sprite.position = offset
	attack_sprite.show()
	attack_sprite.play()
	attack_box.monitoring = true


func bonk_over() -> void:
	# determine if there is a mimic at the given location by
	# looping through all bodies and breaking on the first one
	# to avoid killing multiple at once
	for body in $AttackBox.get_overlapping_bodies():
		if body.is_in_group("MIMIC"):
			print("Mimic " + str(body) + " has been bonked!")
			body.get_bonked(attack_strength)
			break
	bonking = false
	$BonkTimer.stop()
	#this uses signals to hide the attacking nodes after not attacking
	$AttackBox.monitoring = false
	$AttackSprite.stop()
	$AttackSprite.hide()

func hurt(damage):
	emit_signal("update_ui_health", health/max_health)
	health -= damage
	$ouchy.emitting = true
	if health <= 0:
		get_tree().change_scene("res://Scenes//Menus//DeathMenu.tscn")
	


func _on_Sight_body_entered(body: Node) -> void:
	if body.is_in_group("MIMIC"):
		print("froze mimic")
		body.freeze()


func _on_Sight_body_exited(body: Node) -> void:
	if body.is_in_group("MIMIC"):
		body.unfreeze()
