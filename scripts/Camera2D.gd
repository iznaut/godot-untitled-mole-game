extends Camera2D

onready var tween = $Tween


func _process(delta):
	var pos = Global.player.global_position
	var x = floor(pos.x / Global.screen_width) * Global.screen_width
	var y = floor(pos.y / Global.screen_height) * Global.screen_height

	if global_position != Vector2(x,y):
		tween.interpolate_property(
			self, "global_position", global_position,
			Vector2(x,y), 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT
		)
		tween.start()
