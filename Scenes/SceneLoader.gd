extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var blk = $Control/ColorRect

func change_scene(path, delay=0.5):

	var tween := Tween.new()
	blk.add_child(tween)
	tween.interpolate_property(blk, "color", Color(0,0,0,0), Color(0,0,0,1), delay)
	tween.set_active(true)
	yield(tween, "tween_completed")
	
	
	assert(get_tree().change_scene(path) == OK)
	tween.interpolate_property(blk, "color", Color(0,0,0,1), Color(0,0,0,0), delay)
	yield(tween, "tween_completed")
	tween.queue_free()
	
