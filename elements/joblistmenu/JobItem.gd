extends HBoxContainer

export var ALLOWED_VISIBLE_CHARACTERS = 40
export var DIFICULTY_LEVEL = 1
export var DESCRIPTION_TEXT = "Some example of a text"
onready var description = $JobDescription

func _ready():
	var text = DESCRIPTION_TEXT
	if text.length() > ALLOWED_VISIBLE_CHARACTERS:
		var lengthText = (text.length() - 1) 
		var charactersToDelete = lengthText - ALLOWED_VISIBLE_CHARACTERS
		text.erase(ALLOWED_VISIBLE_CHARACTERS, charactersToDelete)
		text = text + "..."
		description.text = text
	description.visible_characters = ALLOWED_VISIBLE_CHARACTERS + 3
	assignStars()
 
func assignStars():
	 match DIFICULTY_LEVEL:
			1:
				print("level ",DIFICULTY_LEVEL)


		
