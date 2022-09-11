extends Control

onready var chooseJob = $JobSelector
onready var timer = $Timer
onready var daysNotification = $DaysNotification
onready var progressBar = $ProgressBar
var daysMessage = "Days: %s"

export(int) var MONTHS_IN_SECONDS=5

var days = 0 

func _on_GetJob_pressed():
	timer.paused = true
	chooseJob.popup()
 
func _on_StartGame_pressed():
	timer.start(MONTHS_IN_SECONDS)
	
func _on_Timer_timeout():
	set_days()
	daysNotification.text = daysMessage % days
	progressBar.value = days
	
func set_days():
	if days >= 31:
		print("is 31!")
		days = 0
	else:
		days += 1
 
func _on_JobSelector_popup_hide():
	timer.paused = false
