extends CharacterBody2D

@export var speed = 400

func talk():
	

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction.normalized() * speed
	if Input.is_action_just_pressed("talk"):
		talk()

func _physics_process(delta):
	get_input()
	move_and_slide()
