class_name Job

var jobName: String
var payment: int
var time: int
 
func _init(value="First Job"):
	jobName = value
	payment = 1000
	time = 2

func simpleFunc():
	print("job is", jobName," qith a payment of",payment)
