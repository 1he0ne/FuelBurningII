extends Node

var fuel_class = preload("res://artAssets/FuelPickup/fuel_pickup.tscn")

func _spawn_fuel_when_destroyed():
	var fuel_instance = fuel_class.instantiate()
	fuel_instance.position = self.position
