extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: PhysicsBody2D):
	if body is preload("res://player/player.gd"):
		body.kill()
