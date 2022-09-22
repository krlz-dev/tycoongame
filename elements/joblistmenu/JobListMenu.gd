extends Popup

var jobsInventory:Array
onready var listContainer = $ScrollContainer/VBoxContainer
const newJobItemResource = preload("res://elements/joblistmenu/JobItem.tscn")

func _ready():
	jobsInventory.append(JobData.new("Simple html page",2,100))
	jobsInventory.append(JobData.new("Concert ads page",2,300))
	jobsInventory.append(JobData.new("CRM project consulting",3,400))
	jobsInventory.append(JobData.new("Pet shop website",5,600))
	jobsInventory.append(JobData.new("Personal blog made in wordpress",3,500))
	jobsInventory.append(JobData.new("Create a social media group with memes",1,10))
	 
	for job in jobsInventory:
		print(job)
		var newJobItem = newJobItemResource.instance()
		newJobItem.DESCRIPTION_TEXT = job.name
		listContainer.add_child(newJobItem)
 
