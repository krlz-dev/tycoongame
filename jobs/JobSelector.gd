extends Node2D
 
onready var chooseJob = $ChooseJob
 
func _on_Button_pressed():
	chooseJob.popup()
