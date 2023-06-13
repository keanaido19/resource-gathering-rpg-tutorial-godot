extends CharacterBody2D


@export var speed: float = 75.0


@onready var animation_tree: AnimationTree = $AnimationTree


var direction: Vector2 = Vector2.ZERO


func _ready():
	animation_tree.active = true
	
	
func _process(delta):
	update_animation_parameters()


func _physics_process(delta):
	# Move in 4 directions
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
	
	if Input.is_action_pressed("use"):
		animation_tree["parameters/conditions/is_swinging_axe"] = true
	else:
		animation_tree["parameters/conditions/is_swinging_axe"] = false
	
	if Vector2.ZERO != direction:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Swing Axe/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
	
