extends CharacterBody2D

@export var speed = 400

func talk():
	var people = get_tree().get_nodes_in_group("Townspeople")
	var closest_person : Node2D
	var min_distance : int = 101
	for person in people:
		var d = position.distance_to(person.position)
		if d < min_distance:
			closest_person = person
	if closest_person != null:
		print(closest_person.person_name, closest_person)
		Dialogic.start("test_timeline")
	

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed
	if Input.is_action_just_pressed("talk"):
		talk()

func _physics_process(delta):
	get_input()
	move_and_slide()
