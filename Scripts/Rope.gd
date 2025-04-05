extends Line2D

@export var start_point:Node2D
@export var end_point:Node2D

func _process(delta: float) -> void:
	clear_points()
	add_point(to_local(start_point.global_position))
	add_point(to_local(end_point.global_position))
