extends Polygon2D

func _ready():
	set_fixed_process(true)
	get_node("boton").hide()

func mostrarTexto(txt):
	get_node("RichTextLabel").iniciar(txt)
	get_node("Timer").start()

func conectarBoton(_func, nodoControlador):
	get_node("boton").connect("pressed", nodoControlador, _func)
	
func ocultar():
	hide()
	
func posicionarTexto(posicion):
	get_node("RichTextLabel").set_pos(posicion)
	
func posicionarBoton(posicion):
	get_node("boton").set_pos(posicion)

func _fixed_process(delta):
	if (Input.is_action_pressed("ui_accept")):
		get_node("RichTextLabel").completarTexto()
