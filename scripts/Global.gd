extends Node

onready var map = get_tree().get_root().get_node("World/Map")

var player : Node2D # set when player is created

var tile_size : int = 16
var tilemap_width : int = 9
var tilemap_height : int = 8
var screen_width : int = 160
var screen_height : int = 144