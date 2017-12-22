extends TextureButton

export var colorInactivo = Color(0.8,0.8,0.8)
export var colorActivo = Color(1,1,1)
var nota;

signal apretado

func _ready():
	set_modulate( colorInactivo )
	nota = str(self.get_parent().get_name())

func _on_botonlb_button_down():
	apretar()
	emit_signal( "apretado" )

func _on_botonlb_button_up():
	desapretar()

func apretar():
	set_modulate( colorActivo )
	get_node("../sonido").play(nota)

func desapretar():
	set_modulate( colorInactivo )

func _on_botonlb_apretado():
	pass # replace with function body
