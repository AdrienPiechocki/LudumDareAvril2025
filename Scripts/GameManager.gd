extends Node2D

var coin = preload("res://Prefabs/Coin.tscn")

var rng = RandomNumberGenerator.new()
var flag:bool = true;

func _process(delta: float) -> void:
	if flag:
		flag = false
		spawnCoin()
		await get_tree().create_timer(rng.randf_range(2,5)).timeout
		flag = true


func spawnCoin():
	var instance = coin.instantiate()
	instance.position = Vector2(rng.randf_range(20, 120), 300)
	add_child(instance)
