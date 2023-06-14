extends Node


class_name Inventory


@export var resources: Dictionary = {}


func add_resources(resource: ResourceItem, amount: int):
	if resources.has(resource):
		resources[resource] = resources[resource] + amount
	else:
		resources[resource] = amount
