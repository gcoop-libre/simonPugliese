extends TextureButton

var textura_normal;
var textura_apretado; 
var nota;
var teclado;

signal apretado

func _ready():
	nota = str(self.get_parent().get_name())
	teclado = get_parent().get_parent().get_parent()
	textura_normal = get_normal_texture()
	textura_apretado = get_pressed_texture()
	
func _on_botonlb_button_up():
	apretar()
	emit_signal( "apretado" )

func apretar():
	teclado.tocar(nota)

func mostrar_como_apretado():
	set_normal_texture(textura_apretado)

func mostrar_normal():
	set_normal_texture(textura_normal)