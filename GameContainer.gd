
class_name GameContainer

extends CanvasLayer

export var min_win = Vector2(500,500)
onready var def_siz = OS.window_size
onready var eliza_chatbox_node = $MainContentBackground/MainContentContainer/VerticalLayoutContainer/MiddleRow/ElizaResponsePanel/ElizaChat

func _ready():
	OS.min_window_size = min_win

func window_resize_handler():
	if not def_siz:
		return
	var winsz = OS.window_size
	var change = Vector2(winsz.x - def_siz.x, winsz.y - def_siz.y)
	if abs(change.x):
		OS.window_size = Vector2(winsz.x,winsz.x)
	else:
		OS.window_size = Vector2(winsz.y,winsz.y)
	
	get_tree().call_group("dynamic_text_size", "do_resize_font")


