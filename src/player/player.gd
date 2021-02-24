extends KinematicBody2D

const MOVE_SPEED = 220.0
const FALL_SPEED = 2500.0
const JUMP_STRENGTH = 510.0

var linear_velocity = Vector2()
var floor_frames = 0
var air_jumps_left = 1

onready var start_position = global_position

func _ready():
	Transition.connect("fade_out_started", self, "freeze")
	Transition.connect("fade_in_ended", self, "unfreeze", [], CONNECT_ONESHOT)
	freeze()

func _process(delta):
	pass

func _physics_process(delta):
	_move_horizontally()
	_jump(delta)
	
	# gravity
	linear_velocity += Vector2(0, FALL_SPEED * delta)
	linear_velocity = move_and_slide(linear_velocity, Vector2(0, -1))
	
	if is_on_floor():
		floor_frames = 8
		air_jumps_left = 1

func _move_horizontally():
	var motion = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		motion += Vector2(1, 0)
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		motion += Vector2(-1, 0)
	
	motion = motion.normalized() * MOVE_SPEED
	move_and_slide(motion, Vector2(0, -1))
	
	if motion != Vector2() and $AnimationPlayer.current_animation != "move":
		$AnimationPlayer.play("move")
	if motion == Vector2() and $AnimationPlayer.current_animation != "idle":
		$AnimationPlayer.play("idle")

func _jump(delta):
	var can_jump = air_jumps_left or floor_frames
	can_jump = can_jump and not test_move(global_transform, Vector2(0, -2))
	
	if Input.is_action_just_pressed("ui_select") and can_jump:
		linear_velocity = -Vector2(0, JUMP_STRENGTH + FALL_SPEED * delta)
		$JumpStreamPlayer.play()
		if not floor_frames:
			air_jumps_left -= 1
		floor_frames = 0
	
	if floor_frames > 0: 
		floor_frames -= 1

func collect(item: Node):
	if item.is_in_group("egg"):
		GameUI.score += 1

func kill():
	if $AnimationPlayer.current_animation == "dead":
		return
	
	GameUI.lives -= 1
	$AnimationPlayer.play("dead")
	freeze()
	
	$HitStreamPlayer.play()
	
	Transition.fade_out(global_position)
	yield(Transition, "fade_out_ended")
	
	if GameUI.lives < 0:
		yield(get_tree().create_timer(1.0), "timeout")
		return get_tree().change_scene("res://levels/gameover/gameover.tscn")
	
	linear_velocity = Vector2()
	global_position = start_position
	unfreeze()
	
	Transition.fade_in(global_position)
	yield(Transition, "fade_in_ended")

func freeze():
	set_physics_process(false)

func unfreeze():
	set_physics_process(true)
