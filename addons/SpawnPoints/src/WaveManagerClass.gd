class_name WaveManagerClass

var waves:Array = []

func _init(_waves):
	self.waves = _waves

func get_size() -> int:
	return waves.size()

# Remove wave configs with size <= 0
func cleanup_waves():
	var indexes = range(waves.size())
	indexes.invert()
	for i in indexes:
		if waves[i].size <= 0:
			waves.remove(i)

# In editor add empty item when last size <> -1
static func add_empty(waves):
	var add_empty:bool = waves.size()== 0
	if (waves.size() > 0):
		var params:Dictionary = waves[waves.size()- 1]
		if params.has("size") and params.size != -1:
			add_empty = true
	if add_empty:
		waves.push_back({"size": -1, "capacity": -1})

func config_spawn_point(spawn_point):
	if waves.size() > 0:
		var config = waves.pop_front()
		spawn_point.config(config.capacity, config.size)
