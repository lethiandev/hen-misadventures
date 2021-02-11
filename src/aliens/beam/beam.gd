extends Area2D

export var length = 1.0 setget set_length

func _ready():
	connect("body_entered", self, "_on_body_entered")
	# make collision shape unique each beam 
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	_update_sprite()
	_update_shape()

func _on_body_entered(body: PhysicsBody2D):
	if body is preload("res://player/player.gd"):
		body.kill()

func set_length(value):
	length = value
	_update_sprite()
	_update_shape()

func _update_sprite():
	var tex = $Sprite.texture
	var factor = 2.0 / tex.get_size().y
	$Sprite.scale.y = length * factor

func _update_shape():
	$CollisionShape2D.shape.extents.y = length * 0.5
	$CollisionShape2D.position.y = length * 0.5
