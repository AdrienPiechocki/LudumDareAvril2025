extends RigidBody2D

@export var maxSpeed:int = 30
@export var acceleration:int = 150
@export var friction:int = 120
@export var axis:Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move(delta)


func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	apply_force(axis * acceleration * delta)
	
