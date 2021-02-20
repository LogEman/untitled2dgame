extends KinematicBody2D

export (int) var speed = 200 # Speed of the player
export (int) var gravity = 5000 # Power of gravity
export (float) var maxJump = 950
export (int) var jumpSpeed = 6000
export (float) var floorPosition = 1150

var jumpOrigin
var isJumpStarted

var velocity = Vector2() # Vector for velocity
	
func _physics_process(delta): # Function controlling player movement and physics
	velocity = Vector2()
	# Player inputs
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		get_node("PlayerSprite").flip_h = true
		get_node("PlayerSprite").play("walk")
	elif !Input.is_action_pressed("ui_right"): 
		get_node("PlayerSprite").stop()
		get_node("PlayerSprite").set_frame(0)
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		get_node("PlayerSprite").flip_h = false
		get_node("PlayerSprite").play("walk")
	elif !Input.is_action_pressed("ui_left"):
		get_node("PlayerSprite").stop()
		get_node("PlayerSprite").set_frame(0)
		
	if position.y < floorPosition: # Y cordinate that gravity stops; The floor(for now)
		velocity.y += delta * gravity # Controls gravity
	if Input.is_action_pressed("ui_up") && !isJumpStarted && position.y > floorPosition && position.y < floorPosition + 5:
		isJumpStarted = true
	if position.y == maxJump || isJumpStarted && !Input.is_action_pressed("ui_up") || position.y <= maxJump:
		isJumpStarted = false
	if (Input.is_action_pressed("ui_up") && isJumpStarted):
		velocity.y -= delta * jumpSpeed + (gravity * delta)
		
	move_and_slide(velocity, Vector2(0, -1)) # Executes player inputs as movements and calculates gravity
	
