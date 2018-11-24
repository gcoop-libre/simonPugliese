extends Node

export var subNivelActual = 0
export var violin = 0
export var bandoneon = 0
export var contrabajo = 0
export var playing_intro = false
export var playing_bg_music = false

var nivelActual = 0
var nivel_1 = {'tipo': 'simon', 'nro': 0}
var nivel_2 = {'tipo': 'laberinto', 'nro': 0}
var nivel_3 = {'tipo': 'simon', 'nro': 1}
var nivel_4 = {'tipo': 'laberinto', 'nro': 1}
var nivel_5 = {'tipo': 'simon', 'nro': 2}
var mapa_niveles = []
var current_scene = null
var orquesta 
var pugliese
var cancion
var dialog
var pausa
var telon
var salir
var link_sitio 
var ayuda

func _ready():
	get_tree().set_auto_accept_quit(false)
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
	mapa_niveles = [nivel_1, nivel_2, nivel_3, nivel_4, nivel_5]
	orquesta = preload("res://orquesta/orquesta.tscn")
	pugliese = preload("res://orquesta/pugliese.tscn")
	pausa = preload("res://pausa.tscn")
	salir = preload("res://salir.tscn")
	dialog = preload("res://dialog/dialog.tscn")
	telon = preload("res://simon/telon.tscn")
	link_sitio = preload("res://menu/link_sitio.tscn")
	ayuda = preload("res://simon/ayuda.tscn")
	play_intro_song()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().set_pause(true)
		pausarSonido()
		call_deferred("promptSalir")

func promptSalir():
	var salirDialog = load("res://menu/salirDialog.tscn").instance()
	prompt(salirDialog)

func prompt(_dialog):
	current_scene.add_child(_dialog)
	_dialog.popup()
	
func resume():
	get_tree().set_pause(false)
	continuarSonido()

func pausarSonido():
	AudioServer.set_stream_global_volume_scale(0)
	AudioServer.set_fx_global_volume_scale(0)

func continuarSonido():
	AudioServer.set_stream_global_volume_scale(1)
	AudioServer.set_fx_global_volume_scale(1)

func esPrimerNivel():
	return (subNivelActual == 0)

func play_intro_song():
	if(!playing_intro):
		get_node("/root/global/musica").stop_all()
		cancion = get_node("/root/global/musica").play('intro_la_yumba')
		playing_intro = true

func play_bg_music():
	get_node("/root/global/musica").stop_all()
	if(mapa_niveles[nivelActual]['tipo'] == 'simon'):
		cancion = get_node("/root/global/musica").play('bar')
	else:
		cancion = get_node("/root/global/musica").play('calle')
	playing_intro = false
	playing_bg_music = true

func stop_bg_music():
	get_node("/root/global/musica").stop_all()
	playing_intro = false
	playing_bg_music = false
		
func empezarJuego():
	nivelActual = 0
	subNivelActual = 0
	violin = 0
	bandoneon = 0
	contrabajo = 0
	call_deferred("_deferred_goto_scene", 'res://simon/principal.tscn')

func siguienteNivel():
	var siguienteNivel = nivelActual + 1
	var siguiente = mapa_niveles[siguienteNivel]
	var tipo_siguiente = siguiente['tipo']
	subNivelActual = siguiente['nro']
	var path
	if(tipo_siguiente == 'simon'):
		path = 'res://simon/principal.tscn'
	else:
		path = 'res://laberinto/laberinto.tscn'
	nivelActual = siguienteNivel
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
    current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()
    # Load new scene
    var s = ResourceLoader.load(path)
    # Instance the new scene
    current_scene = s.instance()
    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)
    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene( current_scene )
    if(current_scene.esJugable()):
        current_scene.add_child(get_boton_pausa())
        current_scene.add_child(get_boton_salir())

func sumarItem(nombreItem):
	self.set(nombreItem, self.get(nombreItem) + 1)
	
func get_orquesta():
	return orquesta.instance()
	
func get_pugliese():
	return pugliese.instance()

func get_dialog():
	var dialogo = dialog.instance()
	dialogo.quitarBoton()
	return dialogo

func get_dialog_jugar():
	var dialogJugar = dialog.instance()
	dialogJugar.get_node("boton").configurarTexturasJugar()
	return dialogJugar

func get_dialog_volver():
	var dialogJugar = dialog.instance()
	dialogJugar.get_node("boton").configurarTexturasVolver()
	return dialogJugar

func apretar_ui_button():
	get_node("sonidos_ui").play("click")
	get_node("TimerBoton").start()
	yield(get_node("TimerBoton"), "timeout")

func get_boton_pausa():
	return pausa.instance()

func get_boton_salir():
	return salir.instance()

func get_link_sitio():
	return link_sitio.instance()

func irAlMenu():
	call_deferred("_deferred_goto_scene", "res://menu/menu.tscn")

func irAAcercaDe():
	call_deferred("_deferred_goto_scene", "res://menu/info.tscn")

func irALosCreditos():
	call_deferred("_deferred_goto_scene", "res://menu/creditos.tscn")

func get_fondo_principal():
	return load(str("res://orquesta/fondo_",subNivelActual,".tscn")).instance();

func get_telon():
	return telon.instance()

func get_ayuda():
	return ayuda.instance()
