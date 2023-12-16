extends Node2D
## Spawns the node in the set scene
##
## 

@export var nodeScene:PackedScene = null


func _ready():
	assert(nodeScene, name + ": you need to set the nodeScene to spawn")
	

func _spawn_node():
	var node = nodeScene.instantiate()
	add_child(node)
	
