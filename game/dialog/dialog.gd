extends Polygon2D
var completo = false
var ok_held = false

func _ready():
	set_process_input(true)
	get_node("boton").hide()

func mostrarTexto(txt):
	get_node("RichTextLabel").iniciar(txt)
	get_node("Timer").start()

func conectarBoton(_func, nodoControlador):
	get_node("boton").connect("pressed", nodoControlador, _func, [], CONNECT_ONESHOT)
	
func conectarTextoCompleto(_func, nodoControlador):
	get_node("RichTextLabel").connect("textoCompleto", nodoControlador, _func, [], CONNECT_ONESHOT)

func ocultar():
	hide()
	
func posicionarTexto(posicion):
	get_node("RichTextLabel").set_pos(posicion)
	
func posicionarBoton(posicion):
	get_node("boton").set_pos(posicion)

func quitarBoton():
	get_node("boton").queue_free()
	
func _input(event):
	var ok = event.is_action_pressed('ui_accept') || event.is_action_pressed("touch")
	if ok and not ok_held:
		apurar()
	ok_held = ok

func apurar():
	if !(completo):
		get_node("RichTextLabel").completarTexto()

func _on_RichTextLabel_textoCompleto():
	completo = true
	set_process_input(false)
