extends Node2D

@export var rTexture : Resource
@export var iXSize : int
@export var iYSize : int

func _ready():
	$TextureRect.texture = rTexture
	$TextureRect.size.x = iXSize
	$TextureRect.size.y = iYSize
	
	$CollisionShape2D.shape.size.x = iXSize
	$CollisionShape2D.shape.size.y = iYSize
