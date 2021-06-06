extends Area2D
class_name GridObject

onready var tween = $Tween
onready var ray = $RayCast2D

export var speed = 8

var map_position : Vector2
var is_underground : bool = false
var parent_room : Node2D setget set_parent_room
var parent_subroom : Area2D

func _ready():
	# make sure object is snapped to grid
	position = position.snapped(Vector2.ONE * Global.tile_size)
	position += Vector2.ONE * Global.tile_size / 2

	# todo set initial collisions based on parents


func set_parent_room(new_value):
	parent_room = new_value


func move(dir):
	var move_direction = dir * Global.tile_size

	ray.cast_to = move_direction
	ray.force_raycast_update()

	if ray.is_colliding():
		var collision_object = ray.get_collider()

		if collision_object.has_method("move"):
			if collision_object.move(dir) == false:
				return
		else:
			return false


	var new_position = position + move_direction

	tween.interpolate_property(
		self, "position", position,
		new_position, 1.0 / speed, Tween.TRANS_EXPO, Tween.EASE_OUT
	)
	tween.start()

	map_position += dir


func change_subroom(source, destination):
	# source.get_node("Objects").remove_child(self)
	# destination.get_node("Objects").call_deferred("add_child", self)

	ray.set_collision_mask_bit(1, destination.get_collision_layer_bit(1))
	ray.set_collision_mask_bit(2, destination.get_collision_layer_bit(2))

	source.hide()
	destination.show()

	parent_subroom = destination
