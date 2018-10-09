
extends KinematicBody2D

signal chocando
signal caminando
signal parando

const WALK_SPEED = 150

var velocity = Vector2()
var animation
var direction = "right"

func _fixed_process(delta):
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -WALK_SPEED
		velocity.y = 0
		moveLeft()
	elif (Input.is_action_pressed("ui_right")):
		velocity.x =  WALK_SPEED
		velocity.y = 0
		moveRight()
	elif(Input.is_action_pressed("ui_up")):
		velocity.y = -WALK_SPEED
		velocity.x = 0
		moveUp()
	elif (Input.is_action_pressed("ui_down")):
		velocity.x = 0
		velocity.y = WALK_SPEED
		moveDown()
	else:
		velocity.y = 0
		velocity.x = 0
		stayStill()

	var motion = velocity * delta
	move(motion)
	
	if(is_colliding()):
		var collider = get_collider()
		emit_signal("chocando", collider)
	else:
		if(motion != Vector2(0,0)):
			emit_signal("caminando")
		else:
			emit_signal("parando")

func _ready():
	animation = get_node("camion")

func moveLeft():
	animation.set_animation("anim-left-move")
	direction = "left"
	
func moveRight():
	animation.set_animation("anim-right-move")
	direction = "right"

func moveUp():
	animation.set_animation("anim-up-move")
	direction = "up"
	
func moveDown():
	animation.set_animation("anim-down-move")
	direction = "down"

func stayStill():
	animation.set_animation(str("anim-",direction,"-stop"))