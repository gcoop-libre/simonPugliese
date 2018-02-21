
extends KinematicBody2D

signal chocando

const GRAVITY = 200.0
const WALK_SPEED = 500

var velocity = Vector2()

func _fixed_process(delta):
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -WALK_SPEED
		velocity.y = 0
	elif (Input.is_action_pressed("ui_right")):
		velocity.x =  WALK_SPEED
		velocity.y = 0
	elif(Input.is_action_pressed("ui_up")):
		velocity.y = -WALK_SPEED
		velocity.x = 0
	elif (Input.is_action_pressed("ui_down")):
		velocity.x = 0
		velocity.y = WALK_SPEED
	else:
		velocity.y = 0
		velocity.x = 0
	
	var motion = velocity * delta
	move(motion)
	
	if(is_colliding()):
		var collider = get_collider()
		emit_signal("chocando", collider)

func _ready():
	set_fixed_process(true)
