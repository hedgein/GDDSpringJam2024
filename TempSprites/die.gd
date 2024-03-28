class_name Die extends Node2D

var sides = [1,2,3,4,5,6]
var rng : RandomNumberGenerator
# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(sides : Array):
	self.sides = sides
	pass
	
func roll() -> int:
	# create a simple animation of the 
	var roll : int = sides[rng.randi_range(0,5)]
	
	return roll

func animate_roll()
