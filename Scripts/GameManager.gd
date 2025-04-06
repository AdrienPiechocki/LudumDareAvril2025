extends Node2D

var coin = preload("res://Prefabs/Coin.tscn")
var rock = preload("res://Prefabs/Rock.tscn")
var rockParticules = preload("res://Prefabs/Particules/FallingRockParticules.tscn")
var bat = preload("res://Prefabs/Bat.tscn")
var rng = RandomNumberGenerator.new()
var flag:bool = true

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	spawnCoin()
	spawnRock()
	spawnBat()

func _process(delta: float) -> void:
	$Label.text = str($Player/Bucket.coins)
	if $Player/Bucket.coins == 20 && flag:
		win()
		
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func win():
	flag = false
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")

func spawnBat():
	var batInstance = bat.instantiate()
	batInstance.position = Vector2(rng.randf_range(50, 70), 300)
	add_child(batInstance)
	await get_tree().create_timer(rng.randf_range(5,10)).timeout
	spawnBat()


func spawnRock():
	
	var iRNG = Vector2(rng.randf_range(20,120), -20)
	
	var rockParticulesInstance = rockParticules.instantiate()
	rockParticulesInstance.position = iRNG
	add_child(rockParticulesInstance)
	rockParticulesInstance.emitting = true
	await get_tree().create_timer(1).timeout
	
	var rockInstance = rock.instantiate()
	rockInstance.position = iRNG
	add_child(rockInstance)
	
	await get_tree().create_timer(rng.randf_range(4,8)).timeout
	spawnRock()
	
func spawnCoin():
	var coinInstance = coin.instantiate()
	coinInstance.position = Vector2(rng.randf_range(20, 120), 300)
	add_child(coinInstance)
	await get_tree().create_timer(rng.randf_range(2,5)).timeout
	spawnCoin()
