extends Node2D
## Spawns the node scene 
##
## Spawns at the spawner's position


@export var nodeScene:PackedScene = null


func _ready():
	assert(nodeScene, name + ": you need to set the nodeScene to spawn")
	

func _spawn_node():
	var node:Node = nodeScene.instantiate()
	add_child(node)
	node.position = global_position
	node.top_level = true
