extends ConfirmationDialog

func _ready():
	pass

func _on_salirDialog_confirmed():
	get_tree().quit()

func _on_salirDialog_popup_hide():
	get_node("/root/global").resume()
