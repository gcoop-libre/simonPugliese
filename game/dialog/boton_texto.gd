extends TextureButton
var ok = false
var ok_held = false

func _ready():
	set_process_input(false)
	hide()
	
func _on_RichTextLabel_textoCompleto():
	show()
	set_process_input(true)
	
func _input(event):
	ok = event.is_action_pressed("ui_accept")
	if ok and not ok_held:
		emit_signal("pressed")
	ok_held = ok

func configurarTexturasJugar():
	set_normal_texture(load("res://assets/buttons/jugar.png"))
	set_pressed_texture(load("res://assets/buttons/jugar_pressed.png"))
	
func configurarTexturasVolver():
	set_normal_texture(load("res://assets/buttons/volver.png"))
	set_pressed_texture(load("res://assets/buttons/volver_pressed.png"))
	