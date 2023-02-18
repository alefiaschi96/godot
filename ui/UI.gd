extends CanvasLayer


func _ready():
	pass


func _on_KimematicBody2DPlayer_pokeball_taken(pokeball_counter):
	$TextureRect/Label.text = str(pokeball_counter)

