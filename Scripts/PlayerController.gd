extends RigidBody2D

@export var acceleration:int = 40000
@export var axis:Vector2 = Vector2.ZERO
@export var coins:int = 0
@export var joints:Array[PinJoint2D]
var coin = preload("res://Prefabs/FallingCoin.tscn")
var hitParticlues = preload("res://Prefabs/Particules/BucketHitParticules.tscn")

# How quickly to move through the noise
var _fNOISE_SHAKE_SPEED: float = 30.0
# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
var _fNOISE_SHAKE_STRENGTH: float = 10.0
# Multiplier for lerping the shake strength to zero
var _fSHAKE_DECAY_RATE: float = 2.0

@onready var _camera : Camera2D
@onready var _rand = RandomNumberGenerator.new()
@onready var _noise = FastNoiseLite.new()

var _fNoise: float = 0.0
var _fShakeStrength: float = 0.0

var _bHaveCoin : bool = false
var flag:bool = true

func _ready() -> void:
	_camera = get_node("../../Camera2D")
	_rand.randomize()
	_noise.seed = _rand.randi()
	# Period affects how quickly the noise changes values

func _process(delta: float) -> void:
	# Fade out the intensity over time
	_fShakeStrength = lerp(_fShakeStrength, .0, _fSHAKE_DECAY_RATE * delta)

	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	_camera.offset = get_noise_offset(delta)

func _physics_process(delta: float) -> void:
	var aBodies : Array[Node2D] = get_colliding_bodies()
	
	if aBodies.size() > 0 :
		for bodyNode2D : Node2D in aBodies :
			if bodyNode2D.is_in_group("Obstacles") && flag:
				cooldown()
				$WallHit.play()
				apply_noise_shake()
				var contact_point : Vector2 = (to_local(global_position) + to_local(bodyNode2D.global_position)) / 2
				var hitParticluesInstance : CPUParticles2D = hitParticlues.instantiate()
				hitParticluesInstance.position = contact_point
				add_child(hitParticluesInstance)
				hitParticluesInstance.emitting = true
				
				if !bodyNode2D.is_in_group("Wall"):
					bodyNode2D.queue_free()
					
				if coins > 0 :
					losingCoin()
	
	move(delta)
	
	if coins < 0:
		coins = 0	
	mass = 1 + coins/2
	$BucketSprite.frame = coins/2
	
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
	if axis.y > 0:
		for joint:PinJoint2D in joints:
			joint.softness = 1.05
	elif axis.y < 0:
		for joint:PinJoint2D in joints:
			joint.softness = 0.95
	else:
		for joint:PinJoint2D in joints:
			joint.softness = 1
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

func get_noise_offset(delta: float) -> Vector2:
	_fNoise += delta * _fNOISE_SHAKE_SPEED
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		_noise.get_noise_2d(1, _fNoise) * _fShakeStrength,
		_noise.get_noise_2d(100, _fNoise) * _fShakeStrength
	)

func apply_noise_shake() -> void:
	_fShakeStrength = _fNOISE_SHAKE_STRENGTH
