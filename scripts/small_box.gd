extends RigidBody2D
class_name MovableBody

func _integrate_forces(state: PhysicsDirectBodyState2D):
	angular_velocity = 0
	rotation = 0
