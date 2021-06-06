extends "res://scripts/GridObject.gd"

signal player_dig(map_position)

var inputs : Dictionary = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
}


func _ready():
	Global.player = self


func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(inputs[dir])

	if Input.is_action_just_pressed("dig"):
		dig()


func set_parent_room(new_value):
	disconnect("player_dig", parent_room, "_on_player_dig")
	connect("player_dig", new_value, "_on_player_dig")

	parent_room = new_value


func dig():
	# ignore on undiggable tile
	if parent_subroom.get_node("Background").get_cellv(map_position) == 1:
		return

	emit_signal("player_dig", map_position)

	var nextSubroomIndex = parent_subroom.get_index() - 1

	if nextSubroomIndex < 0:
		nextSubroomIndex = parent_room.get_child_count() - 1

	var nextSubroom = parent_room.get_child(nextSubroomIndex)

	Global.player.change_subroom(parent_subroom, nextSubroom)
