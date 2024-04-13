extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# part of dynamic text resize group
func do_resize_font():
	var parent_height = get_parent_area_size().y
	var current_font = get_node(".").get("custom_fonts/font")
	current_font.set("size", parent_height * 0.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
