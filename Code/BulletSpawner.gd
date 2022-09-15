extends Area2D

export var num_of_bullets = 20
var firing = true
var bullet_scene = preload("res://Scenes/Bullet.tscn")
export var fire_timer = 3
var max_time = 3
var center_point = transform.origin
export var centered = true
var radius = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# --------------------------------------------------------------
# Update function [updates every frame]
# --------------------------------------------------------------

func _process(delta):
	if firing:
		fire_bullets(delta)
	
# --------------------------------------------------------------
# fire_bullets() Function
# [Every time the timer node goes below zero, it fires
# as many bullets as the num_of_bullets variable and resets
# the timer]
# --------------------------------------------------------------

func fire_bullets(delta):
	fire_timer -= delta
	if fire_timer <= 0.0:
		# Converted to radians to easily get the x and y values for the velocity vector
		var degrees_between_bullets = deg2rad(360 / num_of_bullets)
		for i in num_of_bullets:
			# Creates an instance of a bullet
			var new_inst = bullet_scene.instance()
			if centered:
				new_inst.position = global_position
			else:
				new_inst.position.x = self.global_position.x + rand_range(-radius, radius)
				new_inst.position.y = self.global_position.y + rand_range(-radius, radius)
			# Sets the velocity of the bullet
			new_inst.set_velocity((Vector2(cos(i * rand_range(0, 360)), sin(i * rand_range(0, 360)))))
			get_tree().get_root().add_child(new_inst)
		fire_timer = max_time
