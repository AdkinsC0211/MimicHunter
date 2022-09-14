extends KinematicBody2D

signal hit	#player sends this out when hit by enemy (part of tutorial). can be changed

export var speed = 50		#speed is changeable to wtv we need it to be
var attack_strength: float = 1

# movement function begins
func _ready():
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		#temporary code for testing.
		#this should be bonking in the direction the player is facing
		bonk(Vector2(0,-1))
	elif Input.is_action_just_released("ui_accept"):
		bonk_over()

#it's best practice to use physics process for character movement
#it gives you access to functions for the built in physics system
func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
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
	#this uses signals to hide the attacking nodes after not attacking
	$AttackBox.monitoring = false
	$AttackSprite.stop()
	$AttackSprite.hide()
