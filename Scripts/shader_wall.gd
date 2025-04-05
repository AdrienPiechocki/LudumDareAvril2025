class_name ShaderWall extends StaticBody2D

@export var rTexture : Resource
@export var iXSize : int
@export var iYSize : int

func _ready():
	$TextureRect.texture = rTexture
	$TextureRect.size.x = iXSize
	$TextureRect.size.y = iYSize
	
	$CollisionShape2D.shape.size.x = iXSize-24
	$CollisionShape2D.shape.size.y = iYSize
	$CollisionShape2D.position.y = iYSize/2
