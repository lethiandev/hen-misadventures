extends "res://collectables/collectable.gd"

func collect(by):
	get_tree().call_group("exit", "open")
	
	$Sprite.hide()
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	queue_free()
