extends Node2D

var MainMenu = preload("res://Scenes/MainMenu.tscn")

func _on_button_pressed() -> void:
	get_tree().root.add_child(MainMenu)
