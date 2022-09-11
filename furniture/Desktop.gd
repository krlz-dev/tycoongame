extends Area2D
 
onready var projectMenu = $ChooseProject
 
func _on_Desktop_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			projectMenu.popup()
			
# https://www.youtube.com/watch?v=aYs1z9Xg0MQ  menu
# https://www.youtube.com/watch?v=vO-MWKAaVYo  fonts
