extends Control
export(int) var MONTHS_IN_SECONDS = 5
export(int) var INITIAL_LEVEL = 1
export(int) var CURRENT_MONEY = 500 setget set_current_money
export(int) var MONTH_DAYS = 31
export(int) var RENT = 300
export(int) var SERVICES = 70
export(int) var COFFE = 20
 
onready var jobElements = $JobElements
onready var jobListMenu = $JobElements/JobListMenu
onready var daysTimer = $JobElements/DaysTimer
onready var jobTimer = $JobElements/JobTimer
onready var daysNotification = $JobElements/DaysNotification
onready var selectedJob = $JobElements/SelectedJob
onready var progressBar = $JobElements/ProgressBar
onready var currentMoney = $JobElements/CurrentMoney
onready var gameOver = $GameOver
onready var mainScreen = $MainScreen
onready var workingProgress = $JobElements/Workingprogress
onready var workIsDoneDialog = $JobElements/ReceivedMoney
onready var endMonthDialog = $JobElements/EndMonthDialog
onready var developer = $Developer
 
var daysMessage = "Days: %s"
var selectedJobName = "Selected job: %s"
var currentMoneyMessage = "Current money: %s $us"
var finishedJobMessage = "%s was succesfully finished with %s $us of reward"
var finishMonthMessage = "The month has finished, your expenses this month are %s $us, you currently have: %s $us"
var jobsInventory:Array
  
var days = 0 
var workDays = 0 setget set_working_days
var SELECTED_JOB 
var daysProgressTween= Tween.new() 
var workingProgressTween= Tween.new()

func _ready():
	jobListMenu.connect("select_job", self, "_on_select_job")
	mainScreen.show()
	developer.set_activity("drinking_coffe")
	progressBar.max_value = MONTH_DAYS
	currentMoney.text = currentMoneyMessage % CURRENT_MONEY
	jobElements.add_child(daysProgressTween)
	jobElements.add_child(workingProgressTween)

func _on_select_job(job):
	SELECTED_JOB = job
	jobListMenu.hide()

func _on_StartGame_pressed():
	create_jobs()
	daysTimer.start(MONTHS_IN_SECONDS)
	mainScreen.queue_free()
 
func _on_GetJob_pressed():
	daysTimer.paused = true
	jobListMenu.popup()
	
func set_days():
	if days >= MONTH_DAYS:
		pay_month_expenses()
		days = 0
	else:
		days += 1
				
func pay_month_expenses():
	self.CURRENT_MONEY -= RENT+SERVICES+COFFE
	endMonthDialog.dialog_text = finishMonthMessage % [RENT+SERVICES+COFFE, self.CURRENT_MONEY]
	endMonthDialog.popup()
 
func start_working(job:Object):
	developer.set_activity("working") 
	selectedJob.text = selectedJobName % job.name
	workingProgress.max_value = job.time
	jobTimer.start(1)
	
func _on_DaysTimer_timeout():
	set_days()
	daysNotification.text = daysMessage % days
	daysProgressTween.interpolate_property(progressBar, "value", progressBar.value, days, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	daysProgressTween.start()
	check_money_status()

func _on_JobTimer_timeout():
	self.workDays += 1
	if workDays >= SELECTED_JOB.time:
		jobTimer.stop()
		self.CURRENT_MONEY += SELECTED_JOB.payment
		workIsDoneDialog.dialog_text = finishedJobMessage % [SELECTED_JOB.name,SELECTED_JOB.payment]
		developer.set_activity("drinking_coffe")
		workIsDoneDialog.popup()
		
func set_working_days(value):
	workDays = value
	workingProgressTween.interpolate_property(workingProgress, "value", workingProgress.value, workDays, 0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	workingProgressTween.start()
	
func set_current_money(value):
	CURRENT_MONEY = value
	currentMoney.text = currentMoneyMessage % CURRENT_MONEY
	
func check_money_status():
	if self.CURRENT_MONEY < 0:
		jobElements.queue_free()
		gameOver.popup()
		jobTimer.queue_free()
		daysTimer.queue_free()
		 
func create_jobs():
	jobsInventory.append(JobData.new("Simple html page",2,100,1))
	jobsInventory.append(JobData.new("Concert ads page",2,300,1))
	jobsInventory.append(JobData.new("CRM project consulting",3,400,3))
	jobsInventory.append(JobData.new("Pet shop website",5,600,4))
	jobsInventory.append(JobData.new("Personal blog made in wordpress",3,500,5))
	jobsInventory.append(JobData.new("Create a social media group with memes",1,10,6))
	jobsInventory.append(JobData.new("Simple html page",2,100,1))
	jobsInventory.append(JobData.new("Concert ads page",2,300,7))
	jobsInventory.append(JobData.new("CRM project consulting",3,400,1))
	jobsInventory.append(JobData.new("Pet shop website",5,600,1))
	jobsInventory.append(JobData.new("Personal blog made in wordpress",3,500,1))
	jobsInventory.append(JobData.new("Create a social media group with memes",1,10,1))
	jobsInventory.append(JobData.new("Simple html page",2,100,1))
	jobsInventory.append(JobData.new("Concert ads page",2,300,1))
	jobsInventory.append(JobData.new("CRM project consulting",3,400,1))
	jobsInventory.append(JobData.new("Pet shop website",5,600,1))
	jobsInventory.append(JobData.new("Personal blog made in wordpress",3,500,6))
	jobsInventory.append(JobData.new("Create a social media group with memes",1,10,1))
	jobsInventory.append(JobData.new("Simple html page",2,100,1))
	jobsInventory.append(JobData.new("Concert ads page",2,300,1))
	jobsInventory.append(JobData.new("CRM project consulting",3,400,1))
	jobsInventory.append(JobData.new("Pet shop website",5,600,1))
	jobsInventory.append(JobData.new("Personal blog made in wordpress",3,500,1))
	jobsInventory.append(JobData.new("Create a social media group with memes",1,10,7))
	
	jobListMenu.set_jobs(jobsInventory)
 
func _on_ReceivedMoney_about_to_show():
	daysTimer.paused = true

func _on_ReceivedMoney_popup_hide():
	daysTimer.paused = false
	self.workDays = 0

func _on_JobsMenu_index_pressed(index):
	SELECTED_JOB = {"id":jobsInventory[index].id,"name":jobsInventory[index].name,"time":jobsInventory[index].time, "payment":jobsInventory[index].payment}

func _on_EndMonthDialog_about_to_show():
	daysTimer.paused = true 

func _on_EndMonthDialog_popup_hide():
	daysTimer.paused = false

func _on_JobListMenu_popup_hide():
	daysTimer.paused = false
	start_working(SELECTED_JOB)
