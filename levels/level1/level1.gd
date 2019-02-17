extends "res://levels/level_base/level_base.gd"

func _ready():
	_play_entrance_effect()

func _play_entrance_effect():
	Transition.connect("introduced", $AudioStreamPlayer, "play")
	yield($AudioStreamPlayer, "finished")
	$TileMap/Beam.queue_free()
