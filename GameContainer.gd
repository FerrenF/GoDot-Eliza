
class_name GameContainer

extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var min_win = Vector2(768,500)

func _ready():
	OS.min_window_size = min_win


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
