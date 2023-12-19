extends Area2D
## Stores nodes until they are needed
##
## Removes the nodes from the scene and adds them back on player area enter


@export var disable_activation := false

@onready var nodes_to_activate = $EnableNodesContainer.get_children()


func _ready() -> void:
	self.visible = true
	
	var has_null_element := nodes_to_activate.all(func(e): return e != null)
	assert(has_null_element, name + ": null element in enemies_to_activate")
	
	if nodes_to_activate.size() == 0:
		push_warning(name + ": no node set activate when player nearby")
		
	for node in nodes_to_activate:
		print("removing ", node.name)
		$EnableNodesContainer.remove_child(node)
		

func _on_player_detection_area_entered(_area: Area2D) -> void:
	if disable_activation:
		return
	
	#prevent reactivation
	disable_activation = true
	
	for node in nodes_to_activate:
		await get_tree().process_frame #prevent error adding child
		$EnableNodesContainer.add_child(node)
		
	if has_meta("is_boss") && get_meta("is_boss"): AudioPlayer.play_bgm(AudioPlayer.boss_music)
		

