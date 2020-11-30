extends Node2D


func _ready():
	$SpawnPoint2D.connect("item_placed", self, "random_place_item")
	$"SpawnPoint2D-2".connect("item_placed", self, "random_place_item")
	$"SpawnPoint2D-3".connect("item_placed", self, "random_place_item")

func random_place_item(item):
	item.rect_position.x += rand_range(-20, 20)
	item.rect_position.y += rand_range(-20, 20)
