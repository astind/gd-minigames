extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed: int = 400
export var jump_force: int = 200
export var gravity: int = 800

var on_ground: bool = false

var vel: Vector2 = Vector2()

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	vel.x = 0
	if Input.is_action_just_pressed("ui_left"):
		vel.x -= speed
	if Input.is_action_just_pressed("ui_right"):
		vel.x += speed
		
	vel = move_and_slide(vel, Vector2.UP)
	vel.y += gravity * delta
	
	#jump input
	if Input.is_action_just_pressed("ui_up") and on_ground:
		vel.y -= jump_force
		
	if vel.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if vel.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = vel.x < 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
