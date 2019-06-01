extends Node2D

signal animation_finished
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selectedSprite = null

# Called when the node enters the scene tree for the first time.
func _ready():
	selectedSprite = $Sprite.texture
	pass # Replace with function body.

func changeSpriteToSelected():
	changeSprite(selectedSprite)

func selectSprite(newSprite):
	selectedSprite = newSprite

func changeSprite(newSprite):
	$Sprite.texture = newSprite

func startTurn():
	for i in range(3):
		$AnimationPlayer.play("HandAnimation")
		yield($AnimationPlayer, "animation_finished")
		if i == 1:
			emit_signal("animation_finished")
	
