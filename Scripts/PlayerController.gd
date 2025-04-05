extends RigidBody2D

@export var acceleration:int = 40000
@export var axis:Vector2 = Vector2.ZERO
@export var coins:int = 0

var coin = preload("res://Prefabs/FallingCoin.tscn")

var _bHaveCoin : bool = false
var flag:bool = true

func _physics_process(delta: float) -> void:
	var aBodies : Array[Node2D] = get_colliding_bodies()
	
	if aBodies.size() > 0 :
		for bodyNode2D : Node2D in aBodies :
			if bodyNode2D.is_in_group("Obstacles") && flag:
				cooldown()
				$WallHit.play()
				
				if bodyNode2D.is_in_group("Rock"):
					bodyNode2D.queue_free()
					
				if coins > 0 :
					losingCoin()
	
	move(delta)
	
	if coins < 0:
		coins = 0	
	mass = 1 + coins
	
	if abs(linear_velocity.x) > 125:
		if linear_velocity.x > 0:
			linear_velocity.x = 125
		else:
			linear_velocity.x = -125

func cooldown():
	flag = false
	await get_tree().create_timer(0.5).timeout
	flag = true

func get_input_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	apply_force(axis * acceleration * delta)

func addCoin():
	coins += 1
	_bHaveCoin = true

func losingCoin():
	var coinInstance : Node2D = coin.instantiate()
	coinInstance.position = $Marker2D4.position
	add_child(coinInstance)
	coins -= 1
	_bHaveCoin = coins <= 0
