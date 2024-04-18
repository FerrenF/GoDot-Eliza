extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var toggle_state = 1
onready var textures = [load("res://Art/sound_disabled.png"),load("res://Art/sound_enabled.png")]

func _toggleButtonState():
	toggle_state = (toggle_state + 1) % 2
	self.icon = textures[toggle_state]
	get_tree().current_scene.find_node("BackgroundAudio").toggleAudio(toggle_state)
		
func _ready():
	self.icon = textures[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
