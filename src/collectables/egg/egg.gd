extends "res://collectables/collectable.gd"

func collect(by):
	$Sprite.hide()
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	queue_free()
