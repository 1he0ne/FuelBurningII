extends Node

var fuel_class := preload("res://artAssets/FuelPickup/fuel_pickup.tscn")

func _spawn_fuel_when_destroyed() -> void:
	var fuel_instance: FuelPickup = fuel_class.instantiate()
	
	var x := func() -> void:
		get_node("../../../").add_child(fuel_instance)
		fuel_instance.global_position = get_parent().global_position
		
	x.call_deferred()
