class_name ShaderTexture extends Node

@export var rTexture : Resource
@export var iXSize : int
@export var iYSize : int

func _ready():
	$TextureRect.texture = rTexture
	$TextureRect.size.x = iXSize
	$TextureRect.size.y = iYSize
