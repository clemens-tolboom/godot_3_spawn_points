class_name SpawnPoint2D, "res://addons/spawn/SpawnPoint2D.png"

# Can tool cleanup the interface?
# https://docs.godotengine.org/en/stable/tutorials/misc/running_code_in_the_editor.html#doc-running-code-in-the-editor
# tool
# if Engine.editor_hint:
# if not Engine.editor_hint:

extends Node2D

export (bool) var start_immediate = true
export (float) var new_wave_every_seconds = 2.0

export (int) var capacity = 50
export (int) var wave_size = 5
export (Array, PackedScene) var products

onready var add_to_parent = get_node("..")
onready var timer:Timer = $Timer

var products_left: int = capacity

var spawn_point: SpawnPointClass

func _ready():
	spawn_point = SpawnPointClass.new(products, capacity, wave_size)
	spawn_point.capacity = capacity
	spawn_point.wave_size = wave_size

	timer.set_wait_time(new_wave_every_seconds)
	timer.start()

	if start_immediate:
		do_wave()

func _on_Timer_timeout():
	do_wave()

func do_wave():
	if not visible:
		return

	var items:Array = spawn_point.do_wave()

	for p in items:
		add_to_parent.call_deferred("add_child", p)

		p.rect_position.x = position.x + rand_range(-20, 20)
		p.rect_position.y = position.y + rand_range(-20, 20)
