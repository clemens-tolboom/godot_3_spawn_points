# Can tool cleanup the interface?
# https://docs.godotengine.org/en/stable/tutorials/misc/running_code_in_the_editor.html#doc-running-code-in-the-editor
# tool
# if Engine.editor_hint:
# if not Engine.editor_hint:

extends Node2D

export (int) var capacity = 50
export (int) var wave_size = 5
export (bool) var start_immediate = true
export (float) var new_wave_every_seconds = 2.0
export (Array, PackedScene) var products

onready var add_to_parent = get_node("..")
onready var timer:Timer = $Timer

var products_left: int = capacity
	
func _ready():
	timer.set_wait_time(new_wave_every_seconds)
	timer.start()

	if start_immediate:
		do_wave()

func _process(delta):
	if start_immediate:
		start_immediate = false
		do_wave()

func _on_Timer_timeout():
	do_wave()

# No product types available
func is_empty():
	return products.size() == 0

# No products left
func is_depleted():
	return products_left < 1

func get_wave_size():
	return wave_size

func do_wave():
	if is_empty():
		return

	if is_depleted():
		return

	print_debug("Wave", self)
	var packed:PackedScene
	for _i in range(get_wave_size()):
		if is_depleted():
			break

		products.shuffle()
		packed = products[0]
		var p:CanvasItem = packed.instance()
		add_to_parent.add_child(p)

		p.rect_position.x = position.x + rand_range(-20, 20)
		p.rect_position.y = position.y + rand_range(-20, 20)

		products_left -= 1
