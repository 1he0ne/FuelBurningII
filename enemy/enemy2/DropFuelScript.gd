extends Node

var fuel_class = preload("res://artAssets/FuelPickup/fuel_pickup.tscn")

func _spawn_fuel_when_destroyed():
	var fuel_instance = fuel_class.instantiate()
	get_node("../../../").add_child(fuel_instance)
	fuel_instance.global_position = get_parent().global_position
