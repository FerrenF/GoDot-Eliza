extends Node2D

export var min_win = Vector2(500,500)


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.min_window_size = min_win


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start_button_pressed():
	load_eliza_scene()
	
func load_eliza_scene():
	SceneLoader.change_scene("res://Scenes/ElizaDialogScene.tscn",1)
	#get_tree().change_scene("res://Scenes/ElizaDialogScene.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Credits_pressed():
	SceneLoader.change_scene("res://Scenes/credits.tscn",1)
