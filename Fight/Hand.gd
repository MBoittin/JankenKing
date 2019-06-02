extends Node2D

signal animation_finished
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selectedSprite = null
var animation = "HandAnimationEnemy"
var iterator = 0

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

func setPlayerHand():
	print("thing")
	animation = "HandAnimation"

func sendEndTurn():
	if iterator == 3:
		emit_signal("animation_finished")

func startTurn():
	$Sprite.texture = Global.rock
	iterator = 0
	$Sprite.scale.x = 1
	$Sprite.scale.y = 1
	while iterator != 3:
		iterator += 1
		$AnimationPlayer.play(animation)
		yield($AnimationPlayer, "animation_finished")
		
	
