extends Node
var num_mimics_alive: int = 0
signal all_mimics_dead()

func _ready() -> void:
	num_mimics_alive += get_child_count() # hopefully this initiallized in time
	connect("all_mimics_dead", get_tree().get_root(), "on_all_mimics_dead")
	
func decrement_children()->void:
	
	num_mimics_alive -= 1
	print(num_mimics_alive)
	if num_mimics_alive < 1:
		emit_signal("all_mimics_dead")
