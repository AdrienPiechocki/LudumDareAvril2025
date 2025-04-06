extends RigidBody2D

@export var acceleration:int = 40000
@export var axis:Vector2 = Vector2.ZERO
@export var coins:int = 0
@export var joints:Array[PinJoint2D]
var coin = preload("res://Prefabs/FallingCoin.tscn")
var hitParticlues = preload("res://Prefabs/Particules/BucketHitParticules.tscn")

var _cam : Camera2D
var _noise : FastNoiseLite

var _vCamBasePosition : Vector2
var _fShakeTime : float = 0.8
var  _fShakeAmount : float = 150.0
var _fScreenShakeDelay : float

var _bHaveCoin : bool = false
var flag:bool = true

func _ready() -> void:
	_cam = get_node("../../Camera2D")
	_noise = FastNoiseLite.new()

func _process(delta: float) -> void:
	if _fScreenShakeDelay > 0 :
		_cam.global_position = _vCamBasePosition + Vector2(GetNoise(0), GetNoise(1))
		_fScreenShakeDelay -= float(delta)

func _physics_process(delta: float) -> void:
	var aBodies : Array[Node2D] = get_colliding_bodies()
	
	if aBodies.size() > 0 :
		for bodyNode2D : Node2D in aBodies :
			if bodyNode2D.is_in_group("Obstacles") && flag:
				cooldown()
				$WallHit.play()
				ScreenShake()
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

func ScreenShake() -> void :
	_vCamBasePosition = _cam.global_position
	_fScreenShakeDelay = _fShakeTime
	
func GetNoise(iSeed : int) -> float :
	_noise.seed = iSeed
	return _noise.get_noise_1d(randf() * _fScreenShakeDelay) * _fShakeAmount
