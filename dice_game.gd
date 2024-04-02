extends Node2D

var cheats_container : HBoxContainer
var roll_button : Button
var reroll_container : HBoxContainer
var ddown_container : HBoxContainer

var opponent : Townsperson = Global.talking_to
var die1 : Die
var die2 : Die

var roll1 : int
var roll2 : int

var die1_sprites : Array
var die2_sprites : Array

var die_face_list : Array
var die_face_list2 : Array

var max_value : int
var max_map1 : Array
var max_map2 : Array

var low_roller_active : bool = false
var wicked_one_active : bool = false
var vicious_recycle_active : bool = false # don't change when a reroll is used; keep state for double down
var reroll_pending : bool = true # track if a reroll has been used without clearing vicious_recycle_active

var doubled_down : bool = false
var opponent_cheating : bool

# Called when the node enters the scene tree for the first time.
func _ready():# Replace with function body.
	cheats_container = $CheatButtonsContainer
	reroll_container = $RerollButtonsContainer
	ddown_container = $DoubleDownContainer
	roll_button = $RollButton
	$DebugLabel.hide()
	reroll_container.hide()
	ddown_container.hide()
	die1 = $Die
	die2 = $Die2
	die1.sides = opponent.die_sides_a
	die2.sides = opponent.die_sides_b
	max_value = die1.sides.max() if die1.sides.max() > die2.sides.max() else die2.sides.max()
	die1_sprites = die1.get_sprites_for_all_sides()
	die2_sprites = die2.get_sprites_for_all_sides()
	die_face_list = $HBoxContainer/DieFaceList.get_children()
	die_face_list2 = $HBoxContainer/DieFaceList2.get_children()
	for i in range(0,6):
		die_face_list[i].texture = die1_sprites[i]
		die_face_list2[i].texture = die2_sprites[i]
		# generate a map of which values on the dice are the maximum values
		# this will allow for Low Roller to be toggled on and off correctly
		max_map1.push_back(int(die1.sides[i] == max_value))
		max_map2.push_back(int(die2.sides[i] == max_value))
	# roll chance that opponent is somehow cheating
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randf_range(0,1) <= opponent.cheats:
		opponent_cheating = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_die_lists():
	die1_sprites = die1.get_sprites_for_all_sides()
	die2_sprites = die2.get_sprites_for_all_sides()
	for i in range(0,6):
		die_face_list[i].texture = die1_sprites[i]
		die_face_list2[i].texture = die2_sprites[i]
	

func _on_low_roller_button_toggled(toggled_on: bool):
	low_roller_active = toggled_on
	for i in range(0,6):
		if max_map1[i]:
			die1.sides[i] = (max_value + 1) / 2 if toggled_on else max_value
		if max_map2[i]:
			die2.sides[i] = (max_value + 1) / 2 if toggled_on else max_value
	update_die_lists()	
	pass # Replace with function body.

func _on_wicked_one_button_toggled(toggled_on: bool):
	wicked_one_active = toggled_on
	die1.is_wicked_one = toggled_on
	die2.is_wicked_one = toggled_on
	update_die_lists()
	pass # Replace with function body.

func _on_vicious_recycle_button_toggled(toggled_on: bool):
	vicious_recycle_active = toggled_on
	pass # Replace with function body.

func _on_roll_button_pressed():
	cheats_container.hide()
	roll_button.hide()
	roll_dice()

func _on_reroll_1_button_pressed():
	reroll_container.hide()
	reroll_pending = false
	roll_dice(true, false)
	pass # Replace with function body.


func _on_reroll_2_button_pressed():
	reroll_container.hide()
	reroll_pending = false
	roll_dice(false, true)
	pass # Replace with function body.


func _on_move_on_button_pressed():
	ddown_container.hide()
	lose()
	# go back to the walking scene
	# disable further interaction with the opponent (if possible from here; maybe send a signal?)
	pass # Replace with function body.

func _on_double_down_button_pressed():
	ddown_container.hide()
	doubled_down = true
	reroll_pending = true
	roll_dice()
	pass # Replace with function body.

func roll_dice(die1_active: bool = true, die2_active: bool = true):
	die1.is_rolling = die1_active
	die2.is_rolling = die2_active
	await get_tree().create_timer(1.0).timeout
	die1.is_rolling = false
	die2.is_rolling = false
	if die1_active:
		roll1 = die1.roll()
	if die2_active:
		roll2 = die2.roll()
	if opponent_cheating:
		cheat(die1_active, die2_active)
	if (roll1 + roll2 < 7) or (wicked_one_active and (roll1 == 1 or roll2 == 1)):
		win()
		return
	elif roll1 + roll2 >= 7:
		if vicious_recycle_active and reroll_pending:	
			reroll_container.show()
		elif !doubled_down:
			ddown_container.show()
		else:
			lose()
		pass
	pass # Replace with function body.

func cheat(die1_active: bool = true, die2_active: bool = true):
	if !doubled_down:
		# the first time, opponent is guaranteed to win
		while (roll1 + roll2 < 7) or (wicked_one_active and (roll1 == 1 or roll2 == 1)):
			if die1_active:
				roll1 = die1.roll()
			if die2_active:
				roll2 = die2.roll()
		return
	else:
		# the second time, opponent is guaranteed to lose
		while (roll1 + roll2 >= 7) or (wicked_one_active and (roll1 != 1 and roll2 != 1)):
			if die1_active:
				roll1 = die1.roll()
			if die2_active:
				roll2 = die2.roll()
		return
	pass
	
func win():
	$DebugLabel.set_text("WIN")
	$DebugLabel.show()
	pass
	
func lose():
	$DebugLabel.set_text("LOSE")
	$DebugLabel.show()
	pass

func _on_debug_reload_scene_pressed():
	for i in range(0,6):
		if max_map1[i]:
			die1.sides[i] = max_value
		if max_map2[i]:
			die2.sides[i] = max_value
	get_tree().reload_current_scene()
	pass # Replace with function body.
