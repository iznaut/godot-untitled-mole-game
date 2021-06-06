extends Node2D

onready var floor_underground = get_node("Floor - Underground")
onready var floor_ground = get_node("Floor - Ground")

var room_position : Vector2


func _on_player_dig(map_position):
	# create hole
	floor_underground.get_node("Foreground").set_cellv(map_position, 7)
	floor_ground.get_node("Background").set_cellv(map_position, 5)


func _update_room_exits(invalid_room_cells):
	if Vector2.UP in invalid_room_cells:
		block_tile(Vector2(4,0))
		block_tile(Vector2(5,0))
	if Vector2.RIGHT in invalid_room_cells:
		block_tile(Vector2(9,4))
	if Vector2.DOWN in invalid_room_cells:
		block_tile(Vector2(4,8))
		block_tile(Vector2(5,8))
	if Vector2.LEFT in invalid_room_cells:
		block_tile(Vector2(0,4))


func block_tile(cell):
	var ground_bg = floor_ground.get_node("Background")
	var ground_fg = floor_ground.get_node("Foreground")

	ground_bg.set_cellv(cell, 2)
	ground_fg.set_cellv(cell, 6)
