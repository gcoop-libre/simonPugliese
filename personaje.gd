
extends KinematicBody2D

signal chocando
signal caminando
signal parando

const WALK_SPEED = 150

var velocity = Vector2()
var animation
var humo
var direction = "right"

func _fixed_process(delta):	
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -WALK_SPEED
		velocity.y = 0
		mover("left")
	elif (Input.is_action_pressed("ui_right")):
		velocity.x =  WALK_SPEED
		velocity.y = 0
		mover("right")
	elif(Input.is_action_pressed("ui_up")):
		velocity.y = -WALK_SPEED
		velocity.x = 0
		mover("up")
	elif (Input.is_action_pressed("ui_down")):
		velocity.x = 0
		velocity.y = WALK_SPEED
		mover("down")
	else:
		velocity.y = 0
		velocity.x = 0
		stayStill()
		
	alinearHumo()
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
	humo = get_node("camion/humo")
	
func mover(sentido):
	if(direction != sentido):
		direction = sentido
	animation.set_animation(str("anim-",direction,"-move"))
	humo.set_param(humo.PARAM_LINEAR_VELOCITY,300)
	
func stayStill():
	animation.set_animation(str("anim-",direction,"-stop"))
	humo.set_param(humo.PARAM_LINEAR_VELOCITY,150)

func alinearHumo():
	var offsetParticula = {'up': Vector2(0,60), 'left': Vector2(60,0), 'down': Vector2(0,-50), 'right': Vector2(-70,0)}
	humo.set_emissor_offset(offsetParticula[direction])
	var direccionParticula = {'up': 0, 'left': 90, 'down': 180, 'right': 270}
	humo.set_param(humo.PARAM_DIRECTION, direccionParticula[direction])
