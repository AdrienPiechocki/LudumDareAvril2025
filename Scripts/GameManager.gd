extends Node2D

var coin = preload("res://Prefabs/Coin.tscn")
var rock = preload("res://Prefabs/Rock.tscn")
var bat = preload("res://Prefabs/Bat.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	spawnCoin()
	spawnRock()
	spawnBat()

func spawnBat():
	var instance = bat.instantiate()
	instance.position = Vector2(rng.randf_range(50, 70), 300)
	add_child(instance)
	await get_tree().create_timer(rng.randf_range(5,10)).timeout
	spawnBat()


func spawnRock():
	var instance = rock.instantiate()
	instance.position = Vector2(rng.randf_range(20,120), -20)
	add_child(instance)
	await get_tree().create_timer(rng.randf_range(4,8)).timeout
	spawnRock()
	
func spawnCoin():
	var instance = coin.instantiate()
	instance.position = Vector2(rng.randf_range(20, 120), 300)
	add_child(instance)
	await get_tree().create_timer(rng.randf_range(2,5)).timeout
	spawnCoin()
