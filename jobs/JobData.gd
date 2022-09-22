extends Reference
 
class_name JobData

var id:int
var name:String
var time:int
var payment:int

func _init(_name:String,
		   _time:int,
		   _payment:int):
	 var rng = RandomNumberGenerator.new()
	 id = rng.randi()
	 name = _name
	 time = _time 
	 payment =_payment

