extends CanvasLayer

var	gold_label : Label
var	souls_label : Label
# Called when the node enters the scene tree for the first time.
func _ready():
	gold_label = $GoldLabel
	souls_label = $SoulsLabel
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gold_label.text = "GOLD: " + str(Global.gold)
	souls_label.text = "SOULS: " + str(Global.souls)
	pass
