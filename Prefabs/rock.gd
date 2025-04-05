extends RigidBody2D

func _physics_process(delta: float) -> void:
	if (position.y > get_viewport_rect().end.y):
		queue_free();
