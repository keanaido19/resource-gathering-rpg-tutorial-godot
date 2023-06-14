extends Area2D


class_name Pickup


@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var resource_item: ResourceItem


var launch_velocity: Vector2 = Vector2.ZERO
var launch_duration: float = 0.0
var time_since_launch: float = 0.0
var is_launching: bool = false:
	set(value):
		is_launching = value
		collision_shape.disabled = is_launching


func _ready():
	connect("body_entered", _on_body_entered)


func _process(delta):
	if is_launching:
		position += launch_velocity * delta
		time_since_launch += delta
	
	if time_since_launch >= launch_duration:
		is_launching = false


func launch(velocity: Vector2, duration: float):
	launch_velocity = velocity
	launch_duration = duration
	time_since_launch = 0.0
	is_launching = true


func _on_body_entered(body):
	var inventory: Inventory = body.find_child("Inventory")
	
	if inventory:
		inventory.add_resources(resource_item, 1)
		queue_free()
