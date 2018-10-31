extends HBoxContainer

func _ready():
	sync()

func sync():
	get_node("violin/Background/Number").set_text(str(global.violin))
	get_node("contrabajo/Background/Number").set_text(str(global.contrabajo))
	get_node("bandoneon/Background/Number").set_text(str(global.bandoneon))

func agregarItem(nombreItem):
	global.sumarItem(nombreItem)
	sync()
	get_node("itemSounds").play(nombreItem)