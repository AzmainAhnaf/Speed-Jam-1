extends Area2D

@onready var timer = $Timer
@onready var player = $"../Player"



func _on_body_entered(body):
	print("You died")
	body.position = Vector2(body.last_saved_place_x, body.last_saved_place_y)
