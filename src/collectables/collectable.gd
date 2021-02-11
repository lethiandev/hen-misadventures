extends Area2D

var collected = false

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: PhysicsBody2D):
	if body is preload("res://player/player.gd"):
		if can_collect(body) and not collected:
			collected = true
			body.collect(self)
			collect(body)

func can_collect(by):
	return true

func collect(by):
	pass
