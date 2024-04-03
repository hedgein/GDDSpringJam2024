extends CharacterBody2D

@export var speed = 400

var is_talking = false
var devil_sprite

func talk():
	var people = get_tree().get_nodes_in_group("Townspeople")
	var closest_person : Node2D
	var min_distance : int = 101
	for person in people:
		var d = position.distance_to(person.position)
		if d < min_distance:
			closest_person = person
			min_distance = d
	if closest_person != null:
		is_talking = true
		#print(closest_person.person_name, closest_person)
		Dialogic.start(closest_person.person_name)
	

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed
	if Input.is_action_just_pressed("talk") and !is_talking:
		talk()
		
func _on_timeline_ended():
	is_talking = false
		
func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	devil_sprite = preload("res://samirah_sprites/devil_game_player_devil_sprite_sheet.png")

func _physics_process(delta):
	if !is_talking:
		get_input()
		move_and_slide()
	if !Global.is_day:
		$Sprite2D.texture = devil_sprite
		

