extends TextureProgressBar

var candle_head : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	candle_head = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.is_day:
		value = Global.day_countdown * 10 
		
	else:
		value = Global.night_countdown * 10 
	candle_head.position.y = (275 - (value * 5 / 3))
	print("---------", value)
