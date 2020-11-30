extends Button


var pos:Vector2 = Vector2(0,450)
var vel:Vector2 = Vector2(1,0)

func _process(delta):
	set_global_position(get_global_position() + vel)


func _on_SpawnPoint2D_item_placed(item):
	# Try not too overlap the items
	item.rect_position.x += rand_range(-20, 20)
	item.rect_position.y += rand_range(-20, 20)

func _on_SpawnPoint2D_is_depleted(who):
	vel = Vector2.ZERO
