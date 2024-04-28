extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var menuScene = "res://Scenes/menu.tscn"
func _back_home():
	SceneLoader.change_scene(menuScene,1)


func _on_Home_pressed():
	_back_home()
