extends CSGBox


func _process(delta):
	translation.x += 0.01


func _on_SpawnPoint_item_placed(item):
	# Place dropped items a little randomly
	item.translation.x += (randf() - 0.5) / 10.0
	item.translation.z += (randf() - 0.5) / 10.0
