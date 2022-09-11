extends Area2D


export var bullet_speed = 150
var bullet_velocity = Vector2(0, 0)
var bullet_position = Vector2(0, 0)
export var bullet_time = 10

func _ready():
	pass

# --------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
# --------------------------------------------------------------
# Pass in the movement vector [velocity vector]
	# Probably a Vector2().normalized() of the bullet spawn point to the spawner origin position
func set_velocity(velocity):
	bullet_velocity = velocity.normalized()
	
func set_position(position):
	bullet_position = position
	global_translate(bullet_position)

#---------------------------------------------------------------
# Called every frame [the update() function]
# --------------------------------------------------------------
# Update position of the bullet
# Check if there are any collisions
# Do any other checks or updates in this function
func _process(delta):
	do_movement(delta)
	if_timer_done()
	
func do_movement(delta):
	global_translate(bullet_velocity * delta * bullet_speed)
	bullet_position += bullet_velocity
	
func if_timer_done():
	if bullet_time <= 0.0:
		queue_free()


