extends Camera2D

@export var player: CharacterBody2D
@export var tilemap: TileMap

func _ready():
	var map_rect = tilemap.get_used_rect()
	var tile_size = tilemap.cell_quadrant_size
	var world_size = map_rect.size * tile_size
	
	limit_right = world_size.x / 6
	limit_bottom = world_size.y / 6
	
	print(limit_right)
	print(limit_bottom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position
	var x = floor(position.x / 480) * 480
	var y = floor(position.y / 240 ) * 240
	if x > floor(limit_right * 0.7):
		x = floor(limit_right *0.7)
	if y > floor(limit_bottom * 0.7):
		y = floor(limit_bottom *0.7)
	position = Vector2(x,y)
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", Vector2(x,y), 0.10)
