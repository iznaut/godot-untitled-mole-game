extends TileMap

onready var parent_subroom = get_parent()
onready var parent_room = parent_subroom.get_parent()


func _ready():
	var spawns = get_used_cells()

	if !spawns.empty():
		for s in spawns:
			var tile_id = get_cell(s.x, s.y)
			var parent = self
			var object

			if tile_id == 4 and !Global.player:
				object = preload("res://scenes/Player.tscn").instance()
				parent = Global.map
			if tile_id == 7:
				object = preload("res://scenes/Entrance.tscn").instance()
			if tile_id == 8:
				object = preload("res://scenes/Boulder.tscn").instance()

			if object:
				parent.add_child(object)
				object.position = map_to_world(s) + Vector2(8, 8)
				object.map_position = s

				object.parent_room = parent_room
				object.parent_subroom = parent_subroom
				
			set_cellv(s, -1)