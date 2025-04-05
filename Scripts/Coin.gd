extends CharacterBody2D

@export var speed:int = 750

func _physics_process(delta: float) -> void:
	move(delta)
	
func move(delta):
	velocity = Vector2(0,-1) * speed * delta
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	get_parent().add_child($CoinParticules)
	get_node("../CoinParticules").position = position
	$CoinParticules.emitting = true
	get_node("../CoinHit").play()
	get_node("../Player/Bucket").addCoin()
	queue_free()
