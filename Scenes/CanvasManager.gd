extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# dialog_text = load_dialog_text() # doesn't work but we might need it

func _process(delta):
	$Sprite.global_position = $Sprite.get_global_mouse_position()

