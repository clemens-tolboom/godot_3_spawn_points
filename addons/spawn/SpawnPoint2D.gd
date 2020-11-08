tool
class_name SpawnPoint2D, "res://addons/spawn/SpawnPoint2D.png"

signal is_depleted(who)

extends Node2D

export (bool) var start_immediate = true
export (float) var new_wave_every_seconds = 2.0

export (int) var capacity = 50
export (int) var wave_size = 5
export (NodePath) var place_products_into
export (Array, PackedScene) var products

onready var add_to_parent = get_node(place_products_into)
onready var timer:Timer = $Timer

var spawn_point: SpawnPointClass

func _ready():
	if Engine.editor_hint:
		return

	spawn_point = SpawnPointClass.new(products, capacity, wave_size)

	timer.set_wait_time(new_wave_every_seconds)
	timer.start()

	if start_immediate:
		do_wave()

	# When restarted/reconfigured we do have to continue deliver waves
	start_immediate = true

func _on_Timer_timeout():
	do_wave()

func config(capacity, wave_size):
	spawn_point.config(capacity, wave_size)
	if start_immediate:
		do_wave()

func do_wave():
	if not visible:
		return

	if spawn_point.is_depleted():
		emit_signal("is_depleted", self)
		return

	var items:Array = spawn_point.do_wave()

	for p in items:
		add_to_parent.call_deferred("add_child", p)

		p.rect_position.x = position.x + rand_range(-20, 20)
		p.rect_position.y = position.y + rand_range(-20, 20)

