extends Node2D
## Spawns the node scene 
##
## Spawns at the spawner's position


@export var nodeScene:PackedScene = null
var nodeContainer: Node = self

func _ready() -> void:
	assert(nodeScene, name + ": you need to set the nodeScene to spawn")
	
	var level_bullet_container: Node = null
	level_bullet_container = get_tree().get_nodes_in_group("bullets_container")[0]
	if level_bullet_container:
		nodeContainer = level_bullet_container
	else:
		push_warning("nodeContainer should not be itself. Otherwise deleting the spawner will also delete the bullets")
		

func _spawn_node() -> void:
	var node:Node = nodeScene.instantiate()
	nodeContainer.add_child(node)
	node.position = global_position
	node.top_level = true
