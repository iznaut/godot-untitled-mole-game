extends "res://scripts/GridObject.gd"


func _ready():
	connect("area_entered", self, "_on_area_entered")


func _on_area_entered(area):
	if area == Global.player:
		area.parent_room = parent_room
		area.parent_subroom = parent_subroom
		area.map_position = map_position