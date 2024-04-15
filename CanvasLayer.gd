extends CanvasLayer

export(Texture) var empty_cursor = null
export(Texture) var real_cursor = null

func _ready():
	Input.set_custom_mouse_cursor(real_cursor, Input.CURSOR_ARROW)
	# dialog_text = load_dialog_text() # doesn't work but we might need it

func _process(delta):
	$Sprite.global_position = $Sprite.get_global_mouse_position()


