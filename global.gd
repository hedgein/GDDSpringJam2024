extends Node
# Global Singleton
var day_mins = 0.3
var day_countdown = 60.0 * day_mins
var night_mins = 0.3
var night_countdown = 60.0 * night_mins

var talking_to : Townsperson = Townsperson.new()

var is_day = true

var gold : int = 60000
var souls : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# IF DAY: 
	if is_day:
		#print(day_countdown)
		day_countdown -= delta
		# check when day ends
		if day_countdown <= 0:
			#print("switching to night")
			is_day = false
			day_countdown = 60.0 * day_mins
	# IF NIGHT
	else:
		#print(night_countdown)
		night_countdown -= delta
		# check when night ends
		if night_countdown <= 0:
			#print("switching to day")
			is_day = true
			night_countdown = 60.0 * night_mins
