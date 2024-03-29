class_name Die extends Node2D

var sides = [1,2,3,4,5,6] # only thing that really needs to be customized
var rng : RandomNumberGenerator
var sprite : Sprite2D
var die_sprites : Array

var is_wicked_one : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	sprite = $Sprite2D
	
	for filePath in DirAccess.get_files_at("res://TempSprites/dice_frames/"):
		var fullPath = "res://TempSprites/dice_frames/" + filePath  
		if filePath.get_extension() == "png":  
			die_sprites.append( load(fullPath) )
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
	change_face(roll)
	return roll
	
func change_face(roll : int):
	if is_wicked_one and roll == 1:
		sprite.texture = die_sprites[9]
	else:
		sprite.texture = die_sprites[roll - 1]

# mostly exists for the die lists in dice_game
func get_sprites_for_all_sides() -> Array:
	var all_sides = []
	for s in sides:
		if is_wicked_one and s == 1:
			all_sides.append(die_sprites[9])
		else:
			all_sides.append(die_sprites[s - 1])
	return all_sides
