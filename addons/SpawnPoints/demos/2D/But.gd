extends Button



func _process(delta):
	set_global_position(get_global_transform().origin + Vector2(1,0))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
