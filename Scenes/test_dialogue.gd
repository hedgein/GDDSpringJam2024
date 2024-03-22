extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	pass

func _on_button_pressed():
		# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
	
	Dialogic.start_timeline("test_timeline")

	#if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		#Dialogic.start('chapterA')

