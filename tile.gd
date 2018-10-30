extends TileMap

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func posicionarNodoItem(itemNode):
	get_node("items").add_child(itemNode)
