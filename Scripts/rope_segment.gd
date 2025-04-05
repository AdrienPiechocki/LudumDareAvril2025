class_name RopeSegment extends RigidBody2D

@export var start_point : Node2D
@export var end_point : Node2D

func _process(delta: float) -> void:
	$Line2D.clear_points()
	$Line2D.add_point(to_local(start_point.global_position))
	
	if end_point.is_in_group("RopeSegment"):
		$Line2D.add_point(to_local(end_point.StartPointGlobalPosition()))
	else :
		$Line2D.add_point(to_local(end_point.global_position))

func StartPointGlobalPosition() -> Vector2 :
	return $StartPoint.global_position
