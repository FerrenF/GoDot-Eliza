extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var can_flicker = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	can_flicker = true


var flicker_timer = 0.0
var flicker_duration = 0.1 # Duration for each flicker cycle
var min_brightness = 0.6
var max_brightness = 1.0

func _process(delta: float) -> void:
	flicker_timer += delta
	
	if can_flicker and flicker_timer > flicker_duration:
		flicker_timer = 0.0
		flicker()
		
func flicker() -> void:
	var stylebox = self.get_stylebox("panel")
	var color = stylebox.bg_color
	color.a = rand_range(0.7, 0.8) # Randomize alpha for transparency
	#var multiplier = rand_range(0.95,1.1)
	#color.r *= multiplier
	#color.g *= multiplier
	#color.b *= multiplier
	stylebox.bg_color = color
	self.add_stylebox_override("panel", stylebox)
