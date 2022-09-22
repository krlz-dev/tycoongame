extends Popup

var jobsInventory:Array
onready var listContainer = $ScrollContainer/VBoxContainer
const newJobItemResource = preload("res://elements/joblistmenu/JobItem.tscn")
onready var close= $Button

signal select_job(job)
 
func set_jobs(jobsInventory:Array):
	for job in jobsInventory:
		var newJobItem = newJobItemResource.instance()
		newJobItem.connect("select_job", self, "_on_select_job")
		newJobItem.set_description(job)
		listContainer.add_child(newJobItem)

func _on_Button_pressed():
	self.hide()

func _on_select_job(job):
	emit_signal("select_job", job)  
	
