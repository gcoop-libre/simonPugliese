extends KinematicBody2D

export var instrumento = ""

func _ready():
	set_fixed_process(true)
	
func configurar(posicionInstrumento):
	self.instrumento = posicionInstrumento.instrumento
	self.set_pos(posicionInstrumento.get_pos())
	get_node(instrumento).show()