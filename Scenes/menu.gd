extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start_button_pressed():
	load_eliza_scene()
	
func load_eliza_scene():
	get_tree().change_scene("res://Scenes/ElizaDialogScene.tscn")


func _on_Quit_pressed():
	get_tree().quit()
