extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _fixed_process(delta):
	if(Input.is_action_pressed("ui_accept")):
		emit_signal("pressed")
		set_fixed_process(false)