extends Node2D

@export var person_name = ""
@export var x : int
@export var y : int
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(x,y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
