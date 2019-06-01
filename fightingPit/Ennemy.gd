extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scissors = preload("res://fightingPit/Ciseaux.jpg")
var paper = preload("res://fightingPit/Papier.jpg")
var rock = preload("res://fightingPit/Pierre.jpg")

signal hint_finished

var symbolsArray = [rock, paper, scissors]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func giveHint(symbol):
	$Sprite.texture = symbolsArray[symbol]
	$AnimationPlayer.play("Hints")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("hint_finished")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
