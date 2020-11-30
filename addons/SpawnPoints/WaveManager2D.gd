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
var wave_manager: WaveManagerClass

func _ready():
	if not has_valid_spawn_point():
		return

	spawn_point = get_parent()

	if Engine.editor_hint:
		# We don't need a wavemanager object when editing
		return

	spawn_point.connect("is_depleted", self, "_on_SpawnPoint2D_is_depleted")

	wave_manager = WaveManagerClass.new(waves)
	wave_manager.cleanup_waves()

func _get_configuration_warning():
	if not has_valid_spawn_point():
		return "Parent must be a SpawnPoint2D"
	return ""

func has_valid_spawn_point() -> bool:
	var p = get_parent()
	return p is SpawnPoint2D || not spawn_point == null

func _process(delta):
	if Engine.editor_hint:
		update_configuration_warning()
		# Static call
		WaveManagerClass.add_empty(waves)

		# Sync SpawnPoint with first wave data
		if has_valid_spawn_point():
			var p = get_parent()
			p.wave_size = waves[0].size
			p.capacity = waves[0].capacity

func config_spawn_point():
	wave_manager.config_spawn_point(spawn_point)

func _on_SpawnPoint2D_is_depleted(who):
	if who != spawn_point:
		return

	config_spawn_point()
