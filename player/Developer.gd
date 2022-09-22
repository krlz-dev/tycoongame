extends KinematicBody2D
 
onready var developer = $AnimatedSprite
 
func _ready():
	set_activity("drinking_coffe")
 
func set_activity(value:String):
	 match value:
			"drinking_coffe": 
				developer.play(value)
				developer.speed_scale = 0.1
			"working": 
				developer.play(value)
				developer.speed_scale = 1.5
