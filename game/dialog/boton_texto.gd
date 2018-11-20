extends TextureButton

func _ready():
	hide()

func _on_RichTextLabel_textoCompleto():
	show()
	
func configurarTexturasJugar():
	set_normal_texture(load("res://assets/buttons/jugar.png"))
	set_pressed_texture(load("res://assets/buttons/jugar_pressed.png"))
	
func configurarTexturasVolver():
	set_normal_texture(load("res://assets/buttons/volver.png"))
	set_pressed_texture(load("res://assets/buttons/volver_pressed.png"))