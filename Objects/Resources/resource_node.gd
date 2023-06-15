extends StaticBody2D


class_name ResourceNode


@onready var level_parent = get_parent()

@export var node_types: Array[ResourceNodeType]
@export var starting_resources: int = 1
@export var pickup_type: PackedScene
@export var launch_speed: float = 100.0
@export var launch_duration: float = 0.15


var current_resources: int:
	set(value):
		current_resources = value
		if value <= 0:
			queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	current_resources = starting_resources


func harvest(amount: int):
	for n in amount:
		spawn_resource()
	current_resources -= amount


func spawn_resource():
	var pickup_instance: Pickup = pickup_type.instantiate() as Pickup
	
	level_parent.call_deferred("add_child", pickup_instance)
	pickup_instance.position = position
	
	var direction: Vector2 = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)		
	).normalized()
	
	pickup_instance.launch(launch_speed * direction, launch_duration)
