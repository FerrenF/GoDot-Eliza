extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var text_states = ["Learn more...", "Launch browser"]
export var url = "https://sites.google.com/view/elizagen-org/About"
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = text_states[0]
func _lmbtnOver():
	self.text = text_states[1]
func _lmbtnOut():
	self.text = text_states[0]
func _lmbtnPress():
	OS.shell_open(url)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
