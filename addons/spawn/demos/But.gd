extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	move_to_center_and_then_disappear()

func move_to_center_and_then_disappear():
	var l:Vector2 = get_global_transform().origin
	l.x += 1
	set_global_position(l)
