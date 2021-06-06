extends Node2D

signal update_room_exits(invalid_room_cells)

export(String, DIR) var rooms_directory

onready var room_cells : Array = get_parent().get_node("HUD/Minimap").get_used_cells()

var player_scene : PackedScene = preload("res://scenes/Player.tscn")
var room_compass = [
	Vector2.UP,
	Vector2.RIGHT,
	Vector2.DOWN,
	Vector2.LEFT
]


func _ready():
	var room_scenes = []
	var dir = Directory.new()
	dir.open(rooms_directory)
	dir.list_dir_begin(true)
	
	var room = dir.get_next()
	while room != "":
		var room_scene = load(rooms_directory + '/' + room)

		if room_scene:
			room_scenes.append(room_scene)

		room = dir.get_next()

	for rc in room_cells:
		var new_room = room_scenes[randi() % room_scenes.size()].instance()

		add_child(new_room)

		new_room.position = rc * Vector2(Global.screen_width, Global.screen_height)
		new_room.room_position = rc
		connect("update_room_exits", new_room, "_update_room_exits")

		var invalid_room_cells = []
	
		for room_dir in room_compass:
			if !(new_room.room_position + room_dir in room_cells):
				invalid_room_cells.push_back(room_dir)

		emit_signal("update_room_exits", invalid_room_cells)
		disconnect("update_room_exits", new_room, "_update_room_exits")
