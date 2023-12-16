extends Node2D

const boss_icon = "res://artAssets/MapIcons/exclamationLarge.png"
const repair_icon = "res://artAssets/MapIcons/plusLarge.png"
const star_icon = "res://artAssets/MapIcons/star_large.png"
const station_icon = "res://artAssets/MapIcons/station_A.png"

var icons = []
var nav_layers = []

class NavNode:
	var next: Array[NavNode]
	var btn: Button
	
func _generate_node(num_destinations_on_layer: int, layerId: int, i: int, randomNodeType: int) -> NavNode:
	var random_x_offset = randi() % 50
	var random_y_offset = randi() % 50 		
	var dest = NavNode.new()
	
	var button = Button.new()
	button.scale = Vector2(0.5, 0.5)
	button.icon = icons[randomNodeType]
	button.tooltip_text = "maybe this could show 'shop', 'boss', etc."
	#button.text = "we could add text into the btn"
	button.pressed.connect(self._button_pressed)
	button.set_position(Vector2(25+random_x_offset+(600*i)/num_destinations_on_layer,random_y_offset+1000 - layerId*200))
	add_child(button)
	
	dest.btn = button
	return dest
	
func _generate_node_layer(layerId: int):
	var nav_nodes = []
	
	# var num_destinations_on_layer = randi()%2+4
	var num_destinations_on_layer = 4
	
	for i in num_destinations_on_layer:
		var randomNodeType = randi()%icons.size()
		var dest = _generate_node(num_destinations_on_layer, layerId, i, randomNodeType)
		nav_nodes.push_back(dest)
		#print("added nav node %s to layer %s" % [i, layerId])

	nav_layers.push_back(nav_nodes)
		
func _generate_boss_layer(layerId: int):
	var nodes = []
	var boss_node = _generate_node(1, layerId, 0, 0)
	boss_node.btn.global_position.x += 250
	nodes.push_back(boss_node)
	nav_layers.push_back(nodes)
	
	
		
func _link_node_layers():
	for i in nav_layers.size()-1:
		var layer = nav_layers[i]
		var next_layer = nav_layers[i+1]
		
		var count_current_layer = layer.size()
		var count_next_layer = next_layer.size()
		
		# make sure that each node has a next destination, if the layer count is equal
		if count_current_layer <= count_next_layer:
			for j in count_current_layer:
				layer[j].next.push_back(next_layer[j])
				
		else:
			# connect the rest to the right most node
			for j in range(count_current_layer, count_next_layer):
				layer[count_current_layer].next.push_back(next_layer[j])
			
		# randomly add connections to neighbors
		var additional_neighbor_percent = 70
		for nodeId in layer.size():
			if randi() % 100 < additional_neighbor_percent:
				var node = layer[nodeId]
				var target_node_id = clampi(nodeId-1+randi()%3, maxi(nodeId-1,0), count_next_layer-1)

				node.next.push_back(next_layer[target_node_id])
				#print("added connection between node %s and %s (layer %s)" % [nodeId, target_node_id, i+1])

	## TODO connect all destinations to the final boss that can't be escaped
	var pre_boss_layer = nav_layers[nav_layers.size()-2]
	var boss_layer = nav_layers[nav_layers.size()-1]
	for nav_point in pre_boss_layer:
		nav_point.next.push_back(boss_layer[0])
		

func _ready():
	# preload icons at compile time
	icons.push_back(preload(boss_icon))
	icons.push_back(preload(repair_icon))
	icons.push_back(preload(star_icon))
	icons.push_back(preload(station_icon))
	
	_generate_node_layer(0)
	_generate_node_layer(1)
	_generate_node_layer(2)
	_generate_node_layer(3)
	_generate_boss_layer(4)
	
	_link_node_layers()

func _button_pressed():
	print("Hello world!")

func _draw():
	print ("drawing............")
	for layer_id in nav_layers.size()-1: # draw all layers except the last one for now
		var layer = nav_layers[layer_id]
		for destination_id in layer.size():
			var dest : NavNode = layer[destination_id]
			
			for target in dest.next:
					print("drawing %s" % target.btn.get_screen_position())
					var dest_pos = dest.btn.get_screen_position()
					dest_pos.x += 35
					dest_pos.y += 35
					var target_pos = target.btn.get_screen_position()
					target_pos.x += 35
					target_pos.y += 35
					draw_line(dest_pos, target_pos, Color.GREEN, 2.0)

func get_map() -> Array[NavNode]:
	return nav_layers
