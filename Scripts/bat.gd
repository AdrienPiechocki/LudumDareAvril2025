extends CharacterBody2D

@export var speed:int = 1500

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("default") 
	move(delta)
	if (position.y < -get_viewport_rect().end.y):
		queue_free();
	
func move(delta):
	velocity = Vector2(0,-1) * speed * delta
	move_and_slide()
