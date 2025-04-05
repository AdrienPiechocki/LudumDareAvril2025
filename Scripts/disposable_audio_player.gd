class_name DisposableAudioPlayer extends AudioStreamPlayer2D


func _on_finished() -> void:
	queue_free()
