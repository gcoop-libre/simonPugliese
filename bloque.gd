extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var texture_size = get_node("Sprite").get_texture().get_size()
	var shape = CollisionPolygon2D.new()
	shape.set_extents(Vector2(texture_size/2))
	add_shape(shape)