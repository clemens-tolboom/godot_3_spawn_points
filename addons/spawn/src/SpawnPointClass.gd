class_name SpawnPointClass

var capacity = 50
var wave_size = 5
var products

var products_left: int = capacity

func _init(prods, capacity, wave_size):
	self.products = prods
	self.wave_size = wave_size
	self.capacity = capacity

# No product types available
func is_empty():
	return products.size() == 0

# No products left
func is_depleted():
	return products_left < 1

func get_wave_size():
	return wave_size

func do_wave() -> Array:
	if is_empty():
		return []

	if is_depleted():
		return []

	var result = []
	var packed:PackedScene
	for _i in range(get_wave_size()):
		if is_depleted():
			break

		products.shuffle()
		packed = products[0]
		result.push_back(packed.instance())
		products_left -= 1

	return result
