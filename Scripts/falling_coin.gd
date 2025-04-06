extends Node2D

func _physics_process(delta: float) -> void:
	var fSpriteSkew : float = $Sprite2D.skew
	if (position.y > get_viewport_rect().end.y):
		queue_free();
		
	if fSpriteSkew > 89 :
		$Sprite2D.skew = -89
		$ShaderLayerSprite.skew = -89
	else :
		$Sprite2D.skew += 0.5
		$ShaderLayerSprite.skew += 0.5
