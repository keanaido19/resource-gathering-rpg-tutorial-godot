extends Node


class_name Inventory


signal resource_count_changed(resource: ResourceItem, amount: int)

@export var resources: Dictionary = {}


func add_resources(resource: ResourceItem, amount: int):
	if resources.has(resource):
		resources[resource] = resources[resource] + amount
	else:
		resources[resource] = amount
	
	emit_signal("resource_count_changed", resource, resources[resource])
