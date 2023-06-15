extends MarginContainer


@onready var grid: GridContainer = $Grid

@export var item_display_template: PackedScene

var displays: Array[ResourceItemDisplay]
var player_inventory: Inventory

func _ready():
	var player: Player = get_tree().get_first_node_in_group("player")
	
	player_inventory = player.find_child("Inventory") as Inventory
	player_inventory.connect(
		"resource_count_changed", _on_resource_count_changed
	)


func _on_resource_count_changed(resource: ResourceItem, amount: int) -> void:
	print_debug("New count for " + resource.display_name + " is " + str(amount))
	
	# Find existing item display for resource
	var current_display: ResourceItemDisplay
	
	for display in displays:
		if display.resource_type == resource:
			current_display = display
			current_display.update_count(amount)
			displays.append(current_display)
			break
	
	# If none exist, create a new one
	if null == current_display:
		var new_display: ResourceItemDisplay =  item_display_template.instantiate() as ResourceItemDisplay
		grid.add_child(new_display)
		new_display.resource_type = resource
		new_display.update_count(amount)
		current_display = new_display
	
	displays.append(current_display)
