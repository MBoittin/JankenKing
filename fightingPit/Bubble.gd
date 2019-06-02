extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal animation_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func speak():
	$Idle.stop()
	$Append.play("Append")
	$AudioStreamPlayer.pitch_scale = rand_range(0.65, 1.05)
	visible = true
	yield ($Append, "animation_finished")
	$Idle.play("Speaking")

func stopSpeaking():
	$Idle.stop()
	$Vanish.play("Vanish")
	yield($Vanish, "animation_finished")
	$RichTextLabel.clear()
	visible = false
	emit_signal("animation_finished")

func appendText(string, color):
	$RichTextLabel.append_bbcode("[color=" + color + "]" + string + "[/color]")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
