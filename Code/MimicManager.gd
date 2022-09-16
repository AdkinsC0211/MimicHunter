extends Node
var num_mimics_alive: int = 0
signal all_mimics_dead()
export var play_area: Vector2 = Vector2.ZERO # this assumes 0,0 is the top left floor tile
#be sure to input this var in tile coords not world coords
export var num_mimics_to_spawn: int = 0 
var mimic_scene = preload("res://Scenes/Mimic.tscn") 

func _ready() -> void:
	num_mimics_alive += get_child_count() # hopefully this initiallized in time
	connect("all_mimics_dead", get_tree().get_root(), "on_all_mimics_dead")
	populate_field()
	
func decrement_children()->void:
	#calls every time a mimic dies
	num_mimics_alive -= 1
	#print(num_mimics_alive)
	if num_mimics_alive < 1:
		emit_signal("all_mimics_dead")

#area is Vector2 in tilespace
func populate_field(num=num_mimics_to_spawn, area=play_area)->void:
	# randomly spawns specified num of mimcs 
	var tile_size: int = 16
	for mimic in range(num):
		randomize()
		var location = Vector2(rand_range(0.0, area.x*tile_size),rand_range(0.0,area.y*tile_size))
		spawn_mimic(location)
	
#location is in worldspace
func spawn_mimic(location: Vector2)->void:
	var mimic_inst = mimic_scene.instance()
	mimic_inst.name = "mimic" + str(num_mimics_alive)
	mimic_inst.transform.origin = location
	add_child(mimic_inst)
	
	
