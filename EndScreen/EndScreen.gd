extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setEndScreen(sprite1, sprite2, win):
	$doge2.texture = sprite1
	$doge.texture = sprite2
	if win:
		$backGround/Win.play("Win")
		$backGround2/Win.play("Lose")
	else:
		$backGround/Loose.play("Lose")
		$backGround2/Loose.play("Win")
		$YouWin.visible = false
	Global.endGame = true
	pass
	
func _process(delta):
	if Input.is_action_just_released("ui_accept") && Global.endGame:
		get_tree().reload_current_scene()