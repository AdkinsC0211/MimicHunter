extends Area2D

export var num_of_bullets = 14
var bullet_scene = preload("res://Scenes/Bullet.tscn")
export var fire_timer = 2
var max_time = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# --------------------------------------------------------------
# Update function [updates every frame]
# --------------------------------------------------------------

func _process(delta):
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
			# Sets the velocity of the bullet
			new_inst.set_velocity((Vector2(cos(i), sin(i))))
			new_inst.set_position(transform.origin)
			print(transform.origin)
			get_tree().get_root().add_child(new_inst)
		fire_timer = max_time
