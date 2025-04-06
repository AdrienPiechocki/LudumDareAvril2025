extends Control

@export var speed:int = 500
@export var moveDown:bool = false
@export var moveUp:bool = false


func _process(delta: float) -> void:
	if moveDown:
		moveCamDown(delta)
	if moveUp:
		moveCamUp(delta)
	if $Camera2D.position.y >= 256:
		moveDown = false
	if $Camera2D.position.y <= 0:
		moveUp = false

func moveCamDown(delta):
	$Camera2D.position.y += 1 * speed * delta

func moveCamUp(delta):
	$Camera2D.position.y -= 1 * speed * delta

func _on_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	

func _on_button_2_pressed() -> void:
	moveDown = true


func _on_button_3_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	moveUp = true
