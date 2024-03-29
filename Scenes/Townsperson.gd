class_name Townsperson extends Node2D

@export var person_name = "" # should be somehow accessible by dialogic
@export var x : int 
@export var y : int

@export var die_sides_a = [1,2,3,4,5,6] # each of these dice is customizable based on the person's character (their soul)
@export var die_sides_b = [1,3,5,7,9,8]
@export var upper_bound : int # how much gold you can offer to get the max chance of playing
@export var lower_bound : int # highest gold you can offer to still only get the min chance of playing
@export var max_chance : float # chance they will play once you've offered upper_bound gold
@export var min_chance : float # chance they will play if you offer lower_bound gold or less

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(x,y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
