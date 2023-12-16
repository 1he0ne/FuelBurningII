extends Node2D

var buttons = []

const boss_icon = "res://artAssets/MapIcons/exclamationLarge.png"
const repair_icon = "res://artAssets/MapIcons/plusLarge.png"
const star_icon = "res://artAssets/MapIcons/star_large.png"
const station_icon = "res://artAssets/MapIcons/station_A.png"

const icons = [boss_icon, repair_icon, star_icon, station_icon]


func _ready():
	
	var format_string = "Click me, I am %s"

	for i in range(5):
		var random_x_offset = randi() % 50 
		var random_y_offset = randi() % 50
		var button = Button.new()
		# button.icon = icons[randi()%4]
		button.text =  format_string % i
		button.pressed.connect(self._button_pressed)
		button.set_position(Vector2(random_x_offset,random_y_offset+100*i))
		add_child(button)
		buttons.push_back(button)
		
	for i in range(1,4):
		var button = Button.new()
	
		button.text =  format_string % i
		button.pressed.connect(self._button_pressed)
		button.set_position(Vector2(300,100+100*i))
		add_child(button)
		buttons.push_back(button)
		

	
func _button_pressed():
	print("Hello world!")


func _draw():
	for btn_id in buttons.size():
		var from_button : Button = buttons[btn_id]
		var to_button : Button = buttons[(btn_id+1)%buttons.size()]
		var from_button_pos = from_button.get_screen_position()
		var to_button_pos = to_button.get_screen_position()
		draw_line(from_button_pos, to_button_pos, Color.GREEN, 2.0)
	
		
		
	#for i in range(4):
	#	draw_line(Vector2(120, 150+100*i), Vector2(120, 190+100*i), Color.GREEN, 2.0)
		
	#for i in range(3):
	#	draw_line(Vector2(120, 150+100*i), Vector2(300, 190+100*i), Color.GREEN, 2.0)
	
