extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moves = [0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

func startHinting():
	$Ennemy.giveHint(moves[0])
	yield($Ennemy, "hint_finished")
	$Ennemy.giveHint(moves[1])
	yield($Ennemy, "hint_finished")
	$Ennemy.giveHint(moves[2])
	yield($Ennemy, "hint_finished")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		for i in range(3):
			moves[i] = randi() % 3
		print(moves)
		startHinting()
	pass


func _on_Ennemy_hint_finished():
	
	pass # Replace with function body.
