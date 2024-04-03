extends TextureProgressBar

var candle_head : Sprite2D

var normal_head
var fast_head

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	candle_head = $Sprite2D
	max_value = Global.day_mins * 600
	normal_head = preload("res://TempSprites/candle_progress.png")
	fast_head = preload("res://TempSprites/candle_progress_fast.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.is_day:
		value = Global.day_countdown * 10 
	else:
		max_value =  Global.night_mins * 600
		if Global.fast_time:
			candle_head.texture = fast_head
		else:
			candle_head.texture = normal_head
		value = Global.night_countdown * 10 
	candle_head.position.y = (275 - (value * 300 / max_value))
	print("---------", value)
