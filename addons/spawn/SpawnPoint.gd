class_name SpawnPoint, "res://addons/spawn/SpawnPoint.png"

extends Spatial

signal is_depleted(who)
signal item_placed(item)

# Can tool cleanup the interface?
# https://docs.godotengine.org/en/stable/tutorials/misc/running_code_in_the_editor.html#doc-running-code-in-the-editor
# tool
# if Engine.editor_hint:
# if not Engine.editor_hint:

export (bool) var start_immediate = true
export (float) var new_wave_every_seconds = 2.0

export (int) var capacity = 50
export (int) var wave_size = 5
export (NodePath) var place_products_into
export (Array, PackedScene) var products

onready var add_to_parent = get_node("..")
onready var timer:Timer = $Timer

onready var node_to_place_products_into:Node = get_node(place_products_into)
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

	if spawn_point.is_depleted():
		emit_signal("is_depleted", self)
		return

	var items:Array = spawn_point.do_wave()

	for p in items:
		node_to_place_products_into.call_deferred("add_child", p)

		p.translation = global_transform.origin - node_to_place_products_into.global_transform.origin

		emit_signal("item_placed", p)

# React on the item being placed
func _on_SpawnPoint_item_placed(item):
	pass
