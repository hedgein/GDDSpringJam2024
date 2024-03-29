extends Node2D

var opponent : Townsperson = Global.talking_to
var die1 : Die
var die2 : Die

var die1_sprites : Array
var die2_sprites : Array

var die_face_list : Array
var die_face_list2 : Array


# Called when the node enters the scene tree for the first time.
func _ready():# Replace with function body.
	die1 = $Die
	die2 = $Die2
	die1.sides = opponent.die_sides_a
	die2.sides = opponent.die_sides_b
	die1_sprites = die1.get_sprites_for_all_sides()
	die2_sprites = die2.get_sprites_for_all_sides()
	die_face_list = $HBoxContainer/DieFaceList.get_children()
	die_face_list2 = $HBoxContainer/DieFaceList2.get_children()
	for i in range(0,6):
		die_face_list[i].texture = die1_sprites[i]
		die_face_list2[i].texture = die2_sprites[i]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
