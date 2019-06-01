extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func appendText(string, color):
	$RichTextLabel.append_bbcode("[color=" + color + "]" + string + "[/color]")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
