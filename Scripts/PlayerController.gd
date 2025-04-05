extends RigidBody2D

@export var acceleration:int = 150
@export var axis:Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var aBodies : Array[Node2D] = get_colliding_bodies()
	
	if aBodies.size() > 0 :
		for bodyNode2D : Node2D in aBodies :
			if bodyNode2D.is_in_group("Wall"):
				print("touch")
				$WallHit.Play();
	
	move(delta)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	apply_force(axis * acceleration * delta)
	
