class_name Die extends Node2D

var sides = [1,2,3,4,5,6] # only thing that really needs to be customized
var rng : RandomNumberGenerator
var sprite : Sprite2D
var label_sprite : Sprite2D
var die_sprites : Array
var label_sprites : Array

var is_wicked_one : bool = false
var is_rolling : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	sprite = $DieSprite
	label_sprite = $LabelSprite
	
	#for filePath in DirAccess.get_files_at("res://dice_sprites/dice_cubes/"):
		#var fullPath = "res://dice_sprites/dice_cubes/" + filePath  
		#if filePath.get_extension() == "png":  
			#die_sprites.append( load(fullPath) )
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_1.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_2.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_3.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_4.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_5.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_6.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_7.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_8.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_9.png"))
	die_sprites.append(preload("res://dice_sprites/dice_cubes/player_die_devil.png"))
	
	#for filePath in DirAccess.get_files_at("res://dice_sprites/dice_labels/"):
		#var fullPath = "res://dice_sprites/dice_labels/" + filePath  
		#if filePath.get_extension() == "png":  
			#label_sprites.append( load(fullPath) )
	label_sprites.append(preload("res://dice_sprites/dice_labels/1.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/2.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/3.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/4.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/5.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/6.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/7.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/8.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/9.png"))
	label_sprites.append(preload("res://dice_sprites/dice_labels/devil.png"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_rolling:
		roll()
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
		label_sprite.texture = label_sprites[9]
	else:
		sprite.texture = die_sprites[roll - 1]
		label_sprite.texture = label_sprites[roll - 1]

# mostly exists for the die lists in dice_game
func get_sprites_for_all_sides() -> Array:
	var all_sides = []
	for s in sides:
		if is_wicked_one and s == 1:
			all_sides.append(label_sprites[9])
		else:
			all_sides.append(label_sprites[s - 1])
	return all_sides
