extends Node
# Global Singleton
var day_mins = 2.5
var day_countdown = 60.0 * day_mins
var night_mins = 5
var night_countdown = 60.0 * night_mins
var timer_running = false

var check_timeout = false # make comparisons to see if time has run out (set to false during dialogue or game)
# note that the time still runs
var fast_time = false # if time is running faster, when player is in debt

var talking_to : Townsperson = Townsperson.new()

var is_day = true

var gold : int = -60000
var souls : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fast_time = (gold < 0)
	# IF DAY: 
	if is_day:
		#print(day_countdown)
		day_countdown -= delta
		# check when day ends
		if day_countdown <= 0 and check_timeout:
			#print("switching to night")
			get_tree().change_scene_to_file("res://Scenes/NightScene.tscn")
			is_day = false
			day_countdown = 60.0 * day_mins
			
		if BgMusic.has_stream_playback():
			pass
		else:
			BgMusic.playHuman()
	# IF NIGHT
	else:
		#print(night_countdown)
		night_countdown -= delta if !fast_time else delta * 1.5
		# check when night ends
		if night_countdown <= 0 and check_timeout:
			#print("switching to day")
			#get_tree().change_scene_to_file("res://Scenes/TownScene.tscn")
			is_day = true
			night_countdown = 60.0 * night_mins
			
		if BgMusic.stream.resource_path.get_file().get_basename() == "bgHuman":
			BgMusic.stop()
			BgMusic.playDevil()
		elif BgMusic.has_stream_playback():
			pass
		else:
			BgMusic.playDevil()
