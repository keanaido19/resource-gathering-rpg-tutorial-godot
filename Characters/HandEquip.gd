extends Node2D



@onready var tool_hitbox: Area2D = $Area2D

func _on_area_2d_body_entered(body):
	if body is ResourceNode:
		body.harvest()
