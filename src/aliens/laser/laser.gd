extends KinematicBody2D

export(bool) var is_enabled setget enable

var laser_length = 0.0

func _ready():
	$RayCast2D.force_raycast_update()
	var raycasted = $RayCast2D.get_collision_point()
	laser_length = ($RayCast2D.global_position - raycasted).length()
	enable(is_enabled)

func enable(value):
	is_enabled = value
	$Beam.length = laser_length if is_enabled else 0.0
