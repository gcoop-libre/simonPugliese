extends Node2D

var currentPosicion = 0
var patronTocado = []
var textoBienvenida = ["¡Bienvenidos, bienvenidas!", "Osvaldito Pugliese y los músicos quieren armar \nla orquesta y necesitan tu ayuda.", "Te proponemos un desafío ¿Te sumás?", "Prepará las antenas que vas a tener que \nrepetir la melodía"]
var nivel_1 = ['C1', 'D1', 'E2']
var nivel_2 = ['C#1', 'D#1', 'A1']
var nivel_3 = ['A2', 'F#2', 'E2']
var niveles = [nivel_1, nivel_2, nivel_3]
var patron = null
var cantidadNiveles
var dialog
var telon 

signal nivelGanado

func _ready():
	var fondo_nivel = get_node("/root/global").get_fondo_principal()
	get_node("fondo").add_child(fondo_nivel)
	var nroPatron = get_node("/root/global").subNivelActual
	patron = niveles[nroPatron]
	cantidadNiveles = niveles.size()
	get_node("fondo/fondo/escenario").add_child(get_node("/root/global").get_orquesta())
	deshabilitarInput(true)
	conectarTeclado()
	get_node("/root/global").play_bg_music()
	mostrarPugliese()
	instanciarTelon()
	telon.abrir_telon()
	
func instanciarTelon():
	telon = get_node("/root/global").get_telon()
	add_child(telon)
	telon.connect("telonAbierto", self, "_on_telon_abierto", [], CONNECT_ONESHOT)

func _on_telon_abierto():
	remove_child(telon)
	if(get_node("/root/global").esPrimerNivel()):
		animarTextoBienvenida()
	else:
		get_node("btnEmpezar").show()
		get_node("btnEmpezar").set_fixed_process(true)
		get_node("btnEmpezar").set_disabled(false)

func animarTextoBienvenida():
	dialog = get_node("/root/global").get_dialog()
	var polygon = Vector2Array([Vector2(64, 310), Vector2(64, 700), Vector2(610, 700), Vector2(610, 310)])
	dialog.set_polygon(polygon)
	dialog.posicionarTexto(Vector2(92,330))
	dialog.posicionarBoton(Vector2(230,632))
	dialog.mostrarTexto(textoBienvenida)
	dialog.conectarBoton("_on_empezar_pressed", self)
	add_child(dialog)
	
func conectarTeclado():
	for octava in get_node("teclado").get_children():
		for boton in octava.get_children():
			boton.connect("apretado", self, "boton_apretado" )

func boton_apretado(quien):
	deshabilitarInput(true)
	patronTocado.append( str(quien.get_name()) )
	# chequeamos si la nota es la correcta
	if ( checkPatronTocado() ):
		# chequeamos si ya toque las notas que me piden (patron parcial)
		if patronTocado.size() == currentPosicion + 1:
			currentPosicion += 1  
			# chequeamos si ya termine de tocar el patron del nivel
			if currentPosicion == patron.size():
				get_node("teclado/sonidos_ui").play("aplausos")
				animarMusicosOrquesta()
				get_node("label/ganaste").show()
				get_node("label/anim").play("mostrar")
				yield(get_node("label/anim"), "finished")
				get_node("label/ganaste").hide()
				get_node("timerCancion").start()
				tocarCancion()
				yield(get_node("timerCancion"), "timeout")
				get_node("cuadro_texto").queue_free()
				if hayMasNiveles():
					instanciarTelon()
					telon.cerrar_telon()
					yield(telon, "telonCerrado")
					get_node("/root/global").siguienteNivel()
					pass
				else:
					ganarJuego()
			else: 
				get_node("timerRespuesta").start()
				yield( get_node("timerRespuesta"), "timeout" )
				continuarPatron()
		else:
			# si todavia me faltan notas del patron parcial, habilito input
			deshabilitarInput(false)
	else:
		get_node("teclado/sonidos_ui").play("error")
		get_node("label/error").show()
		get_node("label/anim").play("mostrar")
		yield(get_node("label/anim"), "finished")
		get_node("label/error").hide()
		patronTocado = [] 
		continuarPatron()
	
func checkPatronTocado():
	for i in range(patronTocado.size()):
		if str(patronTocado[i]) != str(patron[i]):
			return false
	return true

func jugar():
	mostrarTeclado()
	get_node("teclado/sonidos_ui").play("click")
	currentPosicion = 0
	get_node("btnEmpezar/anim").play("ocultar")
	yield(get_node("btnEmpezar/anim"), "finished")
	get_node("btnEmpezar").set_disabled(true)
	get_node("btnEmpezarDeNuevo").set_fixed_process(false)
	get_node("timerCortito").start()
	yield(get_node("timerCortito"), "timeout")
	continuarPatron()

func continuarPatron():
	patronTocado = []
	for i in range(0,currentPosicion+1):
		var nombreBoton = patron[i]
		var nombreOctava = "octava" + str(nombreBoton[-1])
		var boton = get_node("teclado/"+nombreOctava+"/" + nombreBoton )
		boton.apretar()
		yield( boton, "finApretado")
	deshabilitarInput(false)
	
func deshabilitarInput(booleano):
	for octava in get_node("teclado").get_children():
		for boton in octava.get_children():
			get_node("teclado/"+octava.get_name()+"/"+boton.get_name()+"/boton-lb").set_disabled(booleano)
			get_node("teclado/"+octava.get_name()+"/"+boton.get_name()+"/boton-lb").set_ignore_mouse(booleano)

func hayMasNiveles():
	return cantidadNiveles - 1 > get_node("/root/global").subNivelActual
	
func ganarJuego():
	get_node("label/fin").show()
	get_node("label/anim").play("mostrar")
	yield(get_node("label/anim"), "finished")
	get_node("label/fin").hide()
	get_node("/root/global").stop_bg_music()
	get_node("teclado/sonidos_ui").play("intro_la_yumba")
	mostrarPugliese()
	get_node("btnEmpezarDeNuevo/anim").play("mostrar")
	get_node("btnEmpezarDeNuevo").set_fixed_process(true)

func _on_btnEmpezarDeNuevo_pressed():
	get_node("btnEmpezarDeNuevo").set_fixed_process(false)
	get_node("btnEmpezarDeNuevo/anim").play("ocultar")
	yield(get_node("btnEmpezarDeNuevo/anim"), "finished")
	instanciarTelon()
	telon.cerrar_telon()
	yield(telon, "telonCerrado")
	get_tree().get_root().get_node("/root/global").empezarJuego()

func animarMusicosOrquesta():
	get_node("fondo/fondo/escenario/orquesta").animarMusicos()
	
func mostrarPugliese():
	get_node("teclado").quitar_teclas()
	get_node("fondo/fondo/posicionPugliese/pugliese").show()
	animarMusicosOrquesta()
	get_node("fondo/fondo/posicionPugliese/pugliese").play()

func mostrarTeclado():
	get_node("teclado").mostrar_teclas()

func _on_empezar_pressed():
	dialog.ocultar()
	_on_btnEmpezar_pressed()

func _on_btnEmpezar_pressed():
	get_node("fondo/fondo/posicionPugliese/pugliese").hide()
	jugar()

func esJugable():
	return true
	
func tocarCancion():
	mostrarPugliese()
	var canciones = get_node("canciones")
	canciones.sonar()
	animarTextoCancion()
	
func animarTextoCancion():
	var textoCancion = get_node("canciones").get_texto_cancion()
	dialog = get_node("/root/global").get_dialog()
	var posicion = (get_node("nombre_cancion").get_pos())
	var polygon = Vector2Array([Vector2(posicion.x, posicion.y), Vector2(posicion.x, posicion.y + 80), Vector2(posicion.x + 426, posicion.y + 80), Vector2(posicion.x + 426, posicion.y)])
	dialog.set_polygon(polygon)
	dialog.posicionarTexto(Vector2(posicion.x + 40, posicion.y + 20))
	dialog.mostrarTexto(textoCancion)
	add_child(dialog) 
	dialog.quitarBoton()
	