tool
extends Node2D

class_name WaveManager2D

export (Array, Dictionary) var waves = [
	{
		"size": 3,
		"capacity": 10,
	},{
		"size": 2,
		"capacity": 6,
	},
]

var spawn_point: SpawnPoint2D

func _ready():
	var p = get_parent()
	if p is SpawnPoint2D:
		spawn_point = p
		spawn_point.connect("is_depleted", self, "_on_SpawnPoint2D_is_depleted")

	if Engine.editor_hint:
		return

	# Remove the extra wave config added by the editor.
	var indexes = range(waves.size())
	indexes.invert()
	for i in indexes:
		if waves[i].size < 0:
			waves.remove(i)

func _process(delta):
	if Engine.editor_hint:
		var add_empty:bool = waves.size()== 0
		if (waves.size()> 0):
			#print_debug(spawn_point)
			if spawn_point != null:
				spawn_point.wave_size = waves[0].size
				spawn_point.capacity = waves[0].capacity
			var params:Dictionary = waves[waves.size()- 1]
			if params.has("size") and params.size != -1:
				add_empty = true
		if add_empty:
			waves.push_back({"size": -1, "capacity": -1})

func config_spawn_point():
	if waves.size() > 0:
		print_debug("Next wave config")

		var config = waves.pop_front()
		spawn_point.config(config.capacity, config.size)

func _on_SpawnPoint2D_is_depleted(who):
	if who != spawn_point:
		return
	if waves.size() == 0:
		return

	config_spawn_point()
