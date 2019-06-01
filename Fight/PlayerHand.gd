extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal player_turn_end


var selectedAction = Global.Symbols.scissors

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startTurn():
	$Hand.startTurn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		selectedAction = Global.Symbols.scissors
	if Input.is_action_pressed("ui_left"):
		selectedAction = Global.Symbols.rock
	if Input.is_action_pressed("ui_up"):
		selectedAction = Global.Symbols.paper
	pass


func _on_Hand_animation_finished():
	emit_signal("player_turn_end", selectedAction)
	$Hand.selectSprite(Global.symbolsArray[selectedAction])
	pass # Replace with function body.
