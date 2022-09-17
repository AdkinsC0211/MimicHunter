extends Node
var num_mimics_alive: int = 0
var level_logic: Node
signal all_mimics_dead()
signal change_ui_mimic_num (num_mimics_alive)
export var play_area: Vector2 = Vector2.ZERO # this assumes 0,0 is the top left floor tile
#be sure to input this var in tile coords not world coords
export var num_mimics_to_spawn: int = -1 
var mimic_scene = preload("res://Scenes/Mimic.tscn") 

func _ready() -> void:
	assert(num_mimics_to_spawn != -1, "ERROR: You must specify the number of mimics to spawn")
	assert(play_area != Vector2.ZERO, "ERROR: You must specify the play area")
	
	num_mimics_alive += get_child_count() # hopefully this initiallized in time
	connect("all_mimics_dead", level_logic, "on_all_mimics_dead")
	populate_field()
	
func decrement_children()->void:
	#calls every time a mimic dies
	num_mimics_alive -= 1
	emit_signal("change_ui_mimic_num", num_mimics_alive)
	print(num_mimics_alive)
	if num_mimics_alive < 1:
		print("ALL MIMICS DEAD")
		emit_signal("all_mimics_dead")
		level_logic.on_all_mimics_dead()

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
	num_mimics_alive += 1
	var mimic_inst = mimic_scene.instance()
	mimic_inst.name = "mimic" + str(num_mimics_alive)
	mimic_inst.transform.origin = location
	mimic_inst.manager = self
	add_child(mimic_inst)
	
	
