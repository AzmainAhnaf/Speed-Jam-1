extends Area2D

@onready var sprite = $Sprite2D


func _on_body_entered(body):
	body.is_inside_checkpoint = true
	sprite.texture = preload("res://assets/sprites/checkpoint_active.png")


func _on_body_exited(body):
	body.is_inside_checkpoint = false
	sprite.texture = preload("res://assets/sprites/checkpoint_inactive.png")
