extends Control

@export var speed:int = 500
var moveDown:bool = false
var moveUp:bool = false
var inInfo:bool = false

func _process(delta: float) -> void:
	if moveDown:
		moveCamDown(delta)
	if moveUp:
		moveCamUp(delta)
	if $Camera2D.position.y >= 256:
		moveDown = false
	if $Camera2D.position.y <= 0 && inInfo:
		moveUp = false
		inInfo = false
	if $Camera2D.position.y <= -256:
		moveUp = false

func moveCamDown(delta):
	$Camera2D.position.y += 1 * speed * delta

func moveCamUp(delta):
	$Camera2D.position.y -= 1 * speed * delta

func _on_button_1_pressed() -> void:
	moveUp = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	

func _on_button_2_pressed() -> void:
	moveDown = true
	inInfo = true


func _on_button_3_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	moveUp = true
