extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	Global.gold = 60000
	Global.souls = 0
	Global.timer_running = true
	Global.check_timeout = true
	get_tree().change_scene_to_file("res://Scenes/DayScene.tscn")
	pass # Replace with function body.
