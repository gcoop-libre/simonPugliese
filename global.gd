extends Node

export var subNivelActual = 0
var nivelActual = null
var nivel_1 = {'tipo': 'simon', 'nro': 0}
var nivel_2 = {'tipo': 'laberinto', 'nro': 0}
var nivel_3 = {'tipo': 'simon', 'nro': 1}
var nivel_4 = {'tipo': 'laberinto', 'nro': 1}
var nivel_5 = {'tipo': 'simon', 'nro': 2}
var mapa_niveles = []

var current_scene = null

func _ready():
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1 )
	mapa_niveles = [nivel_1, nivel_2, nivel_3, nivel_4, nivel_5]

func empezarJuego():
	nivelActual = 0
	call_deferred("_deferred_goto_scene", 'res://principal.tscn')
	
func siguienteNivel():
	var siguienteNivel = nivelActual + 1
	var siguiente = mapa_niveles[siguienteNivel]
	var tipo_siguiente = siguiente['tipo']
	subNivelActual = siguiente['nro']
	var path
	if(tipo_siguiente == 'simon'):
		path = 'res://principal.tscn'
	else:
		path = 'res://laberinto.tscn'
	nivelActual = siguienteNivel
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):

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