extends CharacterBody2D

@export var speed:int = 750

func _physics_process(delta: float) -> void:
	move(delta)
	if (position.y < -get_viewport_rect().end.y):
		queue_free();
	
func move(delta):
	velocity = Vector2(0,-1) * speed * delta
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var particules : CPUParticles2D = $CoinParticules
	particules.reparent(get_parent())
	particules.emitting = true
	get_node("../CoinHit").play()
	get_node("../Player/Bucket").addCoin()
	queue_free()
