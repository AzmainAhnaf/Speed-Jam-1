extends Area2D
class_name ladder




func _on_body_entered(body):
	body.is_on_ladder = true
	

func _on_body_exited(body):
	body.is_on_ladder = false
