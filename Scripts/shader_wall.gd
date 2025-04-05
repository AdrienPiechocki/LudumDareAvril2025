extends Node2D

@export var rTexture : Resource

func _ready():
	$TextureRect.texture = rTexture
