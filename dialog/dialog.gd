extends Polygon2D
var completo = false
var ok_held = false

func _ready():
	set_fixed_process(true)
	get_node("boton").hide()

func mostrarTexto(txt):
	get_node("RichTextLabel").iniciar(txt)
	get_node("Timer").start()

func conectarBoton(_func, nodoControlador):
	get_node("boton").connect("pressed", nodoControlador, _func, [], CONNECT_ONESHOT)
	
func ocultar():
	hide()
	
func posicionarTexto(posicion):
	get_node("RichTextLabel").set_pos(posicion)
	
func posicionarBoton(posicion):
	get_node("boton").set_pos(posicion)

func _fixed_process(delta):
	var ok = Input.is_action_pressed('ui_accept')
	if ok and not ok_held:
		apurar()
	ok_held = ok

func apurar():
	if !(completo):
		get_node("RichTextLabel").completarTexto()
	else:
		get_node("boton").emit_signal("pressed")

func _on_RichTextLabel_textoCompleto():
	completo = true
