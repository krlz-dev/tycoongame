extends Control
export(int) var MONTHS_IN_SECONDS = 5
export(int) var INITIAL_MONEY = 500
export(int) var INITIAL_LEVEL = 1
export(int) var CURRENT_MONEY = INITIAL_MONEY

onready var chooseJob = $JobSelector
onready var daysTimer = $DaysTimer
onready var jobTimer = $JobTimer
onready var daysNotification = $DaysNotification
onready var selectedJob = $SelectedJob
onready var progressBar = $ProgressBar
onready var currentMoney = $CurrentMoney

var daysMessage = "Days: %s"
var selectedJobName = "Selected job: %s"
var currentMoneyMessage = "Current money: %s"
var jobOne = Job.new()
 
var days = 0 

func _on_GetJob_pressed():
	daysTimer.paused = true
	chooseJob.popup()
 
func _on_StartGame_pressed():
	daysTimer.start(MONTHS_IN_SECONDS)
 
func set_days():
	if days >= 31:
		print("is 31!")
		days = 0
	else:
		days += 1
 
func _on_JobSelector_popup_hide():
	daysTimer.paused = false
	generateJob()
	selectedJob.text = selectedJobName % jobOne.jobName
	jobTimer.start(jobOne.time)

func generateJob():
	jobOne.jobName = "Simple wordpress site"


func _on_DaysTimer_timeout():
	set_days()
	daysNotification.text = daysMessage % days
	progressBar.value = days

func _on_JobTimer_timeout():
	jobTimer.stop()
	CURRENT_MONEY += jobOne.payment
	print(CURRENT_MONEY)
	currentMoney.text = currentMoneyMessage % CURRENT_MONEY
