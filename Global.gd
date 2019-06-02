extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum Symbols{
	rock,
	paper,
	scissors
}

enum VictoryState {
	player1Win,
	tie,
	player2Win
}

var scissors = preload("res://Fight/Scissors.png")
var paper = preload("res://Fight/Paper.png")
var rock = preload("res://Fight/Rock.png")

var flippedLife = preload("res://fightingPit/HPFliped.png")

var symbolsArray = [rock, paper, scissors]

func getWinner(symbol1, symbol2):
	if symbol1 == symbol2:
		return VictoryState.tie
	if symbol1 == Symbols.rock:
		if symbol2 == Symbols.paper:
			return VictoryState.player2Win
	if symbol1 == Symbols.paper:
		if symbol2 == Symbols.scissors:
			return VictoryState.player2Win
	if symbol1 == Symbols.scissors:
		if symbol2 == Symbols.rock:
			return VictoryState.player2Win
	return VictoryState.player1Win


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
