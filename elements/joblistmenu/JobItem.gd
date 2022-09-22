extends HBoxContainer

export var ALLOWED_VISIBLE_CHARACTERS = 40
const silverStarResource = preload("res://elements/experience/SilverStar.tscn")
const goldenStarResource = preload("res://elements/experience/GoldStar.tscn")
const iridiumStarResource = preload("res://elements/experience/IridiumStar.tscn")
var CURRENT_JOB:Object
var description = Label.new()

signal select_job(job)

func _ready():
	description.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
	self.description.connect("gui_input", self, "_on_handle_click")
	description.mouse_filter = Control.MOUSE_FILTER_PASS
 
func _on_handle_click (event): 
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		emit_signal("select_job", CURRENT_JOB)  

func set_description(job:Object):
	CURRENT_JOB = job
	var id:int =  job.id
	var text:String = job.name
	var payment:int = job.payment
	var difficultyLevel = job.diifficulty
	
	if text.length() > ALLOWED_VISIBLE_CHARACTERS:
		var lengthText = (text.length() - 1) 
		var charactersToDelete = lengthText - ALLOWED_VISIBLE_CHARACTERS
		text.erase(ALLOWED_VISIBLE_CHARACTERS, charactersToDelete)
		text = text + "..."
		
	description.text = text
	description.visible_characters = ALLOWED_VISIBLE_CHARACTERS + 3
	self.add_child(description)
	assignStars(difficultyLevel)
 
func assignStars(difficultyLevel:int):
	match difficultyLevel:
			1:
				self.add_child(silverStarResource.instance())
			2:
				self.add_child(silverStarResource.instance())
				self.add_child(silverStarResource.instance())
			3:
				self.add_child(silverStarResource.instance())
				self.add_child(silverStarResource.instance())
				self.add_child(silverStarResource.instance())
			4:
				self.add_child(goldenStarResource.instance())
			5:
				self.add_child(goldenStarResource.instance())
				self.add_child(goldenStarResource.instance())
			6:
				self.add_child(goldenStarResource.instance())
				self.add_child(goldenStarResource.instance())
				self.add_child(goldenStarResource.instance())
			7:
				self.add_child(iridiumStarResource.instance())
			8:
				self.add_child(iridiumStarResource.instance())
				self.add_child(iridiumStarResource.instance())
			9:
				self.add_child(iridiumStarResource.instance())
				self.add_child(iridiumStarResource.instance())
				self.add_child(iridiumStarResource.instance())

		
